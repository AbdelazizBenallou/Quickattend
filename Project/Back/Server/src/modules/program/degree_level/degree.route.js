// src/modules/program/degree_level/degree.route.js
const express = require("express");
const router = express.Router();
const { viewDegrees, viewDegree } = require("./degree.controller");
const { degreeIdValidator } = require("./degree.validator"); // Ensure this validator exists

// Import Middleware
const verifyAccessToken = require('../../../middleware/verifyAccessToken');
const checkPermission = require('../../../middleware/checkPermission');

/* Degree Level APIs */

/**
 * @openapi
 * tags:
 *   name: Degrees
 *   description: API endpoints for managing degree levels
 */

/**
 * @openapi
 * /v1/degrees:
 *   get:
 *     summary: Get all degrees
 *     tags: [Degrees]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: List of degrees
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden (Missing permission)
 */
router.get(
    '/',
    verifyAccessToken,                  // 1. Check if logged in
    checkPermission("view_degrees"),    // 2. Check if user has 'view_degrees' permission
    viewDegrees                         // 3. Execute controller
);

/**
 * @openapi
 * /v1/degrees/{id}:
 *   get:
 *     summary: Get degree by ID
 *     tags: [Degrees]
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
 *         description: Degree details
 *       404:
 *         description: Degree not found
 *       403:
 *         description: Forbidden
 */
router.get(
    '/:id',
    verifyAccessToken,                  // 1. Check if logged in
    checkPermission("view_degrees"),    // 2. Check if user has 'view_degrees' permission (or create 'view_degree')
    degreeIdValidator,                  // 3. Validate ID format
    viewDegree                          // 4. Execute controller
);

module.exports = router;