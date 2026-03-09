const express = require("express");
const router = express.Router();
const { viewUsers, viewUser, deleteUser } = require("./users.controller");
const checkPermission = require("../../middleware/checkPermission");
const verifyAccessToken = require('../../middleware/verifyAccessToken');
const { userIdValidator } = require('./users.vaidator');

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


module.exports = router;