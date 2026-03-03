const express = require('express');
const router = express.Router();
const prisma = require("../../config/prisma");
const { login, register, refreshToken } = require('./auth.controller');
const { loginValidationRules, validateLogin, registerValidationRules, validateRegistration } = require('./auth.validator');
const verifyRefreshToken = require('../../middleware/verifyRefreshToken');

/* Rate limiter for auth routes */

/** Auth Routes **/

/* Post /v1/auth/login */
router.post('/login', loginValidationRules(), validateLogin, login);

/* Post /v1/auth/register */
router.post('/register', registerValidationRules(), validateRegistration, register);

/* Post /v1/auth/refresh-token */
router.post('/refresh-token', verifyRefreshToken, refreshToken);

/* Post /v1/auth/logout */

module.exports = router;


