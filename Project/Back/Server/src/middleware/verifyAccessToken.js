// src/middleware/verifyAccessToken.js
const jwt = require('jsonwebtoken');
const response = require('../utils/response');
const { ACCESS_SECRET } = require('../config/env');

function verifyAccessToken(req, res, next) {
  // Get access token from cookies first, then fallback to authorization header
  const token = req.cookies?.accessToken || req.headers.authorization?.split(" ")[1];

  // Check if token is provided
  if (!token) {
    return response.error(res, "Unauthorized", 401);
  }

  try {
    const decoded = jwt.verify(token, ACCESS_SECRET);

    // Check if token contains user ID
    if (!decoded.userId) {
      return response.error(res, "Invalid token: Missing user ID", 401);
    }

    req.user = decoded;

    next();

  } catch (err) {
    // Handle token expiration error
    if (err.name === 'TokenExpiredError') {
      return response.error(res, "Access token has expired", 401);
    }

    // Handle invalid token format or signature error
    if (err.name === 'JsonWebTokenError') {
      return response.error(res, "Invalid token format", 401);
    }

    // Return generic error for any other JWT errors
    return response.error(res, "Invalid or expired token", 401);
  }
}

module.exports = verifyAccessToken;