const express = require("express");
const router = express.Router();
const { viewUsers, viewUser, deleteUser, updateProfile } = require("./users.controller");
const checkPermission = require("../../middleware/checkPermission");
const verifyAccessToken = require('../../middleware/verifyAccessToken');
const { userIdValidator, updateProfileValidator } = require('./users.validator');

/**
 * @openapi
 * tags:
 *   name: Users
 *   description: API endpoints for managing users
 */

/**
 * @openapi
 * /v1/users:
 *   get:
 *     summary: Get all users
 *     tags: [Users]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: Users list
 */

router.get(
  "/",
  verifyAccessToken,
  checkPermission("view_users"),
  viewUsers
);

/**
 * @openapi
 * /v1/users/{id}:
 *   get:
 *     summary: Get user by ID
 *     tags: [Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: User ID
 *     responses:
 *       200:
 *         description: User details
 *       404:
 *         description: User not found
 */

router.get(
  "/:id",
  verifyAccessToken,
  checkPermission("view_users"),
  userIdValidator,
  viewUser
);

/**
 * @openapi
 * /v1/users/{id}:
 *   delete:
 *     summary: Delete user
 *     tags: [Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *     responses:
 *       200:
 *         description: User deleted
 *       404:
 *         description: User not found
 */

router.delete(
  "/:id",
  verifyAccessToken,
  checkPermission("delete_user"),
  userIdValidator,
  deleteUser
);

/**
 * @openapi
 * /v1/users/{id}/profile:
 *   put:
 *     summary: Update user profile
 *     tags: [Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: User ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               first_name:
 *                 type: string
 *               last_name:
 *                 type: string
 *               date_birth:
 *                 type: string
 *                 format: date
 *               address:
 *                 type: string
 *               level_id:
 *                 type: integer
 *               specialization_id:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Profile updated successfully
 *       400:
 *         description: Invalid data or IDs
 *       403:
 *         description: Forbidden (Inactive user or missing permission)
 *       404:
 *         description: User not found
 */


router.put(
  "/:id/profile",
  verifyAccessToken,
  checkPermission("update_profile"), // Ensure this permission exists in DB
  userIdValidator,                  // Validates the :id in URL
  updateProfileValidator,           // Validates the body fields
  updateProfile
);

module.exports = router;