const jwt = require('jsonwebtoken');
const response = require('../utils/response');
const { REFRESH_SECRET } = require('../config/env');

async function verifyRefreshToken(req, res, next) {
  // Get refresh token from request body
  const refreshToken = req.body.refreshToken;

  if (!refreshToken) {
    return response.error(res, 'Refresh token is required in request body', 400);
  }

  try {
    // Verify the JWT token
    const decoded = jwt.verify(refreshToken, REFRESH_SECRET);
    const userId = decoded.userId;

    // Check if token has userId
    if (!userId) {
      return response.error(res, 'Invalid refresh token: Missing user ID', 403);
    }

    // Save user info for next steps
    req.refreshPayload = decoded;
    next();

  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return response.error(res, 'Refresh token has expired', 403);
    }
    if (err.name === 'JsonWebTokenError') {
      return response.error(res, 'Invalid refresh token format', 403);
    }
    return response.error(res, 'Invalid or expired refresh token', 403);
  }
}

module.exports = verifyRefreshToken;