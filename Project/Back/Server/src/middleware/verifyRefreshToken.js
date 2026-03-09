const jwt = require('jsonwebtoken');
const response = require('../utils/response')
const { REFRESH_SECRET } = require('../config/env');


function verifyRefreshToken(req, res, next) {

    const refreshToken = req.cookies?.refreshToken || req.body.refreshToken;

    if (!refreshToken) {
        return response.error(res, 'Refresh token is required', 400)
    }

    try {
        const decoded = jwt.verify(refreshToken, REFRESH_SECRET);
        req.refreshPayload = decoded;
        next();

    } catch (err) {
        return response.error(res, 'Invalid or expired refresh token', 403)
    }
}

module.exports = verifyRefreshToken;