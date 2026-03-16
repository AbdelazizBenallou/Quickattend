// src/modules/program/level/level.route.js
const express = require('express');
const router = express.Router();
const { viewLevels, viewLevel } = require('./level.controller');
const { levelIdValidator } = require('./level.validator');

// Import Middleware
const verifyAccessToken = require('../../../middleware/verifyAccessToken');
const checkPermission = require('../../../middleware/checkPermission');

/* Level APIs */

/**
 * @openapi
 * tags:
 *   name: Levels
 *   description: API endpoints for managing levels
 */

/**
 * @openapi
 * /v1/levels:
 *   get:
 *     summary: Get all levels
 *     tags: [Levels]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: List of levels
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden (Missing permission)
 */
router.get(
    '/',
    verifyAccessToken,
    checkPermission('view_levels'),
    viewLevels
);

/**
 * @openapi
 * /v1/levels/{id}:
 *   get:
 *     summary: Get level by ID
 *     tags: [Levels]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Level details
 *       404:
 *         description: Level not found
 *       403:
 *         description: Forbidden
 */
router.get(
    '/:id',
    verifyAccessToken,
    checkPermission('view_levels'),
    levelIdValidator,
    viewLevel
);


module.exports = router;