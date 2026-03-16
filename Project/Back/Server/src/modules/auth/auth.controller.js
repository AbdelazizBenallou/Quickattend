// src/modules/auth/auth.controller.js
const { loginUser, registerUser, refreshAccessToken } = require('./auth.service');
const response = require('../../utils/response');
const { NODE_ENV } = require('../../config/env');

async function login(req, res) {
  try {
    const { email, password } = req.body;

    const ip = req.ip || req.connection.remoteAddress;
    const userAgent = req.get('User-Agent');

    const { accessToken, refreshToken, user } = await loginUser(email, password, ip, userAgent);
    res.cookie('accessToken', accessToken, {
      httpOnly: true,
      secure: NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 5 * 60 * 1000
    });

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: NODE_ENV === 'production',
      sameSite: 'strict',
      maxAge: 7 * 24 * 60 * 60 * 1000
    });

    return response.success(
      res,
      {
        user,
        accessToken,
        refreshToken
      },
      "Login successful"
    );

  } catch (error) {
    console.error('Login error:', error.message);
    return response.error(
      res,
      "Invalid credentials",
      401
    );
  }
}

async function register(req, res) {
  try {
    const { first_name, last_name, email, password } = req.body;
    console.log(first_name, " ", last_name);

    const ip = req.ip || req.connection.remoteAddress;
    const userAgent = req.get('User-Agent');

    const { accessToken, refreshToken, user } =
      await registerUser(first_name, last_name, email, password, ip, userAgent);

    console.log(user);

    res.cookie('accessToken', accessToken, {
      httpOnly: true,
      secure: NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 5 * 60 * 1000
    });

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: NODE_ENV === 'production',
      sameSite: 'strict',
      maxAge: 7 * 24 * 60 * 60 * 1000
    });

    return response.success(
      res,
      {
        user,
        accessToken,
        refreshToken
      },
      "User registered successfully",
      201
    );
  } catch (error) {

    if (error.message === 'Email already exists') {
      console.log("Email Alraedy Exist !")
      return response.error(res, "Registration failed", 409);
    }
    console.log(res)
    return response.error(res, "Registration failed", 400);
  }
}

async function refreshToken(req, res) {
  try {
    const userId = req.refreshPayload.userId; // Get user ID from verified token
    const newAccessToken = await refreshAccessToken(userId); // Generate new access token

    // Set new access token in cookie
    res.cookie('accessToken', newAccessToken, {
      httpOnly: true,
      secure: NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 5 * 60 * 1000 // 5 minutes
    });

    // Send success response
    return response.success(
      res,
      { accessToken: newAccessToken },
      "Access token refreshed successfully"
    );

  } catch (err) {
    if (err.status) {
      return response.error(res, err.message, err.status);
    }
    console.error('Refresh token error:', err);
    return response.error(res, "Could not refresh token due to a server error", 500);
  }
}


module.exports = { login, register, refreshToken };
