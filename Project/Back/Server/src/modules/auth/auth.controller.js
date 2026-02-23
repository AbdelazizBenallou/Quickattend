// src/modules/auth/auth.controller.js
const { loginUser } = require('./auth.service');

async function login(req, res) {
  try {
    const { email, password } = req.body;
    console.log('Login attempt:', { email });

    const ip = req.ip || req.connection.remoteAddress;
    const userAgent = req.get('User-Agent');

    const { accessToken, refreshToken, user } = await loginUser(email, password, ip, userAgent);
    res.cookie('accessToken', accessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // HTTPS only in prod
      sameSite: 'lax',
      maxAge: 5 * 60 * 1000 // 5 minutes
    });

    // Send refresh token (longer-lived)
    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 10 * 60 * 1000 // 10 minutes
    });

    return res.json({
      message: 'Login successful',
      user
    });
  } catch (error) {
    console.error('Login error:', error.message);
    return res.status(401).json({ error: error.message || 'Authentication failed' });
  }
}

module.exports = { login };