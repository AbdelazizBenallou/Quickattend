
const jwt = require('jsonwebtoken');
const response = require('../utils/response');
const { ACCESS_SECRET } = require('../config/env');

function verifyAccessToken(req, res, next) {
  try {
    const token =
      req.cookies?.accessToken ||
      req.headers.authorization?.split(" ")[1];

    if (!token) {
      return response.error(res, "Unauthorized", 401);
    }

    const decoded = jwt.verify(token, ACCESS_SECRET);

    req.user = decoded; // يحتوي userId
    next();

  } catch (err) {
    return response.error(res, "Invalid or expired token", 401);
  }
}

module.exports = verifyAccessToken;