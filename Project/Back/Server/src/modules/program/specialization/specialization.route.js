// src/modules/program/specialization/specialization.route.js
const express = require('express');
const router = express.Router();
const { viewSpecializations, viewSpecialization } = require('./specialization.controller');
const { specializationIdValidator } = require('./specialization.validator');

// Import Middleware
const verifyAccessToken = require('../../../middleware/verifyAccessToken');
const checkPermission = require('../../../middleware/checkPermission');

/* Specialization APIs */

/**
 * @openapi
 * tags:
 *   name: Specializations
 *   description: API endpoints for managing specializations
 */

/**
 * @openapi
 * /v1/specializations:
 *   get:
 *     summary: Get all specializations
 *     tags: [Specializations]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: List of specializations
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden (Missing permission)
 */
router.get(
    '/',
    verifyAccessToken,
    checkPermission('view_specializations'),
    viewSpecializations
);

/**
 * @openapi
 * /v1/specializations/{id}:
 *   get:
 *     summary: Get specialization by ID
 *     tags: [Specializations]
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
 *         description: Specialization details
 *       404:
 *         description: Specialization not found
 *       403:
 *         description: Forbidden
 */
router.get(
    '/:id',
    verifyAccessToken,
    checkPermission('view_specializations'),
    specializationIdValidator,
    viewSpecialization
);  

module.exports = router;