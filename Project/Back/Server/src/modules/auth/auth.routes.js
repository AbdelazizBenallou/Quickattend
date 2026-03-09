const express = require('express');
const router = express.Router();
const prisma = require("../../config/prisma");
const { login, register, refreshToken } = require('./auth.controller');
const { loginValidationRules, validateLogin, registerValidationRules, validateRegistration } = require('./auth.validator');
const verifyRefreshToken = require('../../middleware/verifyRefreshToken');

/* Rate limiter for auth routes */

/** Auth Routes **/

/* Post /v1/auth/login */


/**
 * @openapi
 * tags:
 *   name: Users
 *   description: API endpoints for managing users
 */

/**
 * @openapi
 * /v1/auth/login:
 *   post:
 *     summary: User Login
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *                 example: user@example.com
 *               password:
 *                 type: string
 *                 format: password
 *                 example: password123
 *     responses:
 *       200:
 *         description: Login successful
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: Login successful
 *                 data:
 *                   type: object
 *                   properties:
 *                     user:
 *                       type: object
 *                       properties:
 *                         user_id:
 *                           type: integer
 *                           example: 1
 *                         email:
 *                           type: string
 *                           example: user@example.com
 *                         status:
 *                           type: string
 *                           example: active
 *                         academic:
 *                           type: object
 *                           properties:
 *                             degree:
 *                               type: string
 *                               example: Bachelor
 *                             level:
 *                               type: string
 *                               example: Year 2
 *                             specialization:
 *                               type: string
 *                               example: Computer Science
 *                     accessToken:
 *                       type: string
 *                       example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
 *                     refreshToken:
 *                       type: string
 *                       example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
 *       400:
 *         description: Invalid login credentials
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: false
 *                 message:
 *                   type: string
 *                   example: Invalid credentials
 */

router.post(
    '/login',
    loginValidationRules(),
    validateLogin,
    login
);

/**
 * @openapi
 * /v1/auth/register:
 *   post:
 *     summary: Register new user
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - first_name
 *               - last_name
 *               - email
 *               - password
 *             properties:
 *               first_name:
 *                 type: string
 *                 example: John
 *               last_name:
 *                 type: string
 *                 example: Doe
 *               email:
 *                 type: string
 *                 example: john@example.com
 *               password:
 *                 type: string
 *                 example: password123
 *     responses:
 *       201:
 *         description: User registered
 *       400:
 *         description: Invalid data
 *       409:
 *         description: Email already exists
 */
/* Post /v1/auth/register */
router.post(
    '/register',
    registerValidationRules(),
    validateRegistration,
    register
);

/**
 * @openapi
 * /v1/auth/refresh-token:
 *   post:
 *     summary: Refresh access token
 *     tags: [Authentication]
 *     responses:
 *       200:
 *         description: Access token refreshed
 *       403:
 *         description: Invalid refresh token
 */

/* Post /v1/auth/refresh-token */
router.post(
    '/refresh-token',
    verifyRefreshToken,
    refreshToken
);

/* Post /v1/auth/logout */

module.exports = router;


