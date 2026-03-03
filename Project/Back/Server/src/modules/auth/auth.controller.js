// src/modules/auth/auth.controller.js
const { loginUser, registerUser, refreshAccessToken } = require('./auth.service');

async function login(req, res) {
  try {
    const { email, password } = req.body;

    const ip = req.ip || req.connection.remoteAddress;
    const userAgent = req.get('User-Agent');

    const { accessToken, refreshToken, user } = await loginUser(email, password, ip, userAgent);
    res.cookie('accessToken', accessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
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
      user,
      accessToken: accessToken,
      refreshToken: refreshToken
    });
  } catch (error) {
    console.error('Login error:', error.message);
    return res.status(401).json({ error: error.message || 'Authentication failed' });
  }
}

async function register(req, res) {
  try {
    const { email, password } = req.body;

    const ip = req.ip || req.connection.remoteAddress;
    const userAgent = req.get('User-Agent');

    const { accessToken, refreshToken, user } =
      await registerUser(email, password, ip, userAgent);

    res.cookie('accessToken', accessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 5 * 60 * 1000
    });

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 10 * 60 * 1000
    });

    return res.status(201).json({
      message: 'User registered successfully',
      user,
      accessToken,
      refreshToken
    });

  } catch (error) {
    console.error('Register error:', error.message);

    if (error.message === 'Email already exists') {
      return res.status(409).json({ error: error.message });
    }

    return res.status(400).json({ error: error.message });
  }
}

async function refreshToken(req, res) {

  try {
    const userId = req.refreshPayload.userId;

    const newAccessToken = await refreshAccessToken(userId);

    res.cookie('accessToken', newAccessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 5 * 60 * 1000
    });

    return res.json({
      message: 'New access token generated',
      accessToken: newAccessToken
    });

  } catch (err) {
    return res.status(err.status || 500).json({
      error: err.message || 'Refresh failed'
    });
  }
}


module.exports = { login, register, refreshToken };