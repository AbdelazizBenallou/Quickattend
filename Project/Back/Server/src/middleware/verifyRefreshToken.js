const jwt = require('jsonwebtoken');
const { REFRESH_SECRET } = require('../config/env');

function verifyRefreshToken(req, res, next) {

    const refreshToken = req.cookies?.refreshToken || req.body.refreshToken;

    if (!refreshToken) {
        return res.status(400).json({
            error: 'Refresh token is required'
        });
    }

    try {
        const decoded = jwt.verify(refreshToken, REFRESH_SECRET);
        req.refreshPayload = decoded;
        next();

    } catch (err) {
        return res.status(403).json({
            error: 'Invalid or expired refresh token'
        });
    }
}

function verifyAccessToken(req, res, next){

}
module.exports = verifyRefreshToken, verifyAccessToken;