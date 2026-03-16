// src/middleware/verifyRefreshToken.js
const jwt = require('jsonwebtoken');
const prisma = require('../config/prisma');
const response = require('../utils/response');
const { REFRESH_SECRET } = require('../config/env');

async function verifyRefreshToken(req, res, next) {
  // Get refresh token from cookies first, then fallback to request body
  const refreshToken = req.cookies?.refreshToken || req.body.refreshToken;

  // Check if refresh token is provided
  if (!refreshToken) {
    return response.error(res, 'Refresh token is required', 400);
  }

  try {
    // Verify the JWT token signature and expiration
    const decoded = jwt.verify(refreshToken, REFRESH_SECRET);
    const userId = decoded.userId;

    // Check if token contains user ID
    if (!userId) {
      return response.error(res, 'Invalid refresh token: Missing user ID', 403);
    }

    // Check if user exists and account is active
    const user = await prisma.users.findUnique({
      where: { user_id: userId },
      select: { user_id: true, status: true }
    });

    // If user is not active, revoke all their tokens and return error
    if (!user || user.status !== 'active') {
      return response.error(res, 'User account is not active', 403);
    }

    // Save decoded token and user ID to request object for next middleware
    req.refreshPayload = decoded;
    req.userId = userId;

    // Proceed to next middleware or route handler
    next();

  } catch (err) {
    // Handle token expiration error
    if (err.name === 'TokenExpiredError') {
      // Optionally revoke expired token in database
      await prisma.refresh_tokens.updateMany({
        where: { token: refreshToken },
        data: { revoked: true }
      }).catch(() => { });

      return response.error(res, 'Refresh token has expired', 403);
    }

    // Handle invalid token format error
    if (err.name === 'JsonWebTokenError') {
      return response.error(res, 'Invalid refresh token format', 403);
    }

    // Log unexpected errors for debugging
    console.error('Refresh token verification error:', err);

    // Return generic error for security
    return response.error(res, 'Internal server error', 500);
  }
}

module.exports = verifyRefreshToken;