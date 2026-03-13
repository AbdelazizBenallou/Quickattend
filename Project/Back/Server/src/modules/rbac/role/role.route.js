// src/modules/rbac/role/role.route.js
const express = require("express");
const router = express.Router();
const {
    viewRoles,
    viewRole,
    create,
    update,
    remove,
    viewRolePermissions,
    assignPermissions
} = require("./role.controller");

const { roleIdValidator, roleNameValidator, assignPermissionsValidator } = require('./role.validator');

const checkPermission = require("../../../middleware/checkPermission");
const verifyAccessToken = require('../../../middleware/verifyAccessToken');

/* Role Management APIs */

// GET /v1/rbac/roles - Fetch all roles (requires 'view_roles' permission)
/**
 * @openapi
 * tags:
 *   name: Users
 *   description: API endpoints for managing users
 */

/**
 * @openapi
 * /v1/roles:
 *   get:
 *     summary: Get all roles
 *     tags: [Roles]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: List of roles
 */

router.get(
    '/',
    verifyAccessToken,
    checkPermission("view_roles"),
    viewRoles
);

/**
 * @openapi
 * /v1/roles/{id}:
 *   get:
 *     summary: Get role by ID
 *     tags: [Roles]
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
 *         description: Role fetched
 */

router.get(
    '/:id',
    verifyAccessToken,
    checkPermission("view_role"), // Ensure this permission exists in your DB
    roleIdValidator,
    viewRole
);

// POST /v1/rbac/roles - Create a new role (requires 'create_role' permission)

/**
 * @openapi
 * /v1/roles:
 *   post:
 *     summary: Create a new role
 *     tags: [Roles]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *             properties:
 *               name:
 *                 type: string
 *                 example: admin
 *     responses:
 *       201:
 *         description: Role created successfully
 *       409:
 *         description: Role name already exists
 */
router.post(
    '/',
    verifyAccessToken,
    checkPermission("create_role"), // Ensure this permission exists in your DB
    roleNameValidator, // Validate the 'name' field in the request body
    create
);

// PUT /v1/rbac/roles/:id - Update an existing role by ID (requires 'update_role' permission)
/**
 * @openapi
 * /v1/roles/{id}:
 *   put:
 *     summary: Update role
 *     tags: [Roles]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: admin
 *     responses:
 *       200:
 *         description: Role updated
 *       404:
 *         description: Role not found
 */
router.put(
    '/:id',
    verifyAccessToken,
    checkPermission("update_role"), // Ensure this permission exists in your DB
    roleIdValidator,    // Validate the 'id' parameter
    roleNameValidator,  // Validate the 'name' field in the request body
    update
);

// DELETE /v1/rbac/roles/:id - Delete a role by ID (requires 'delete_role' permission)

/**
 * @openapi
 * /v1/roles/{id}:
 *   delete:
 *     summary: Delete role
 *     tags: [Roles]
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
 *         description: Role deleted successfully
 *       404:
 *         description: Role not found
 */
router.delete(
    '/:id',
    verifyAccessToken,
    checkPermission("delete_role"), // Ensure this permission exists in your DB
    roleIdValidator,
    remove
);

// GET /v1/rbac/roles/:id/permissions - Fetch permissions assigned to a specific role (requires 'view_role_permissions' permission)

/**
 * @openapi
 * /v1/roles/{id}/permissions:
 *   get:
 *     summary: Get permissions assigned to a role
 *     tags: [Roles]
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
 *         description: Permissions list
 *       404:
 *         description: Role not found
 */

router.get(
    '/:id/permissions',
    verifyAccessToken,
    checkPermission("view_role_permissions"), // Ensure this permission exists in your DB
    roleIdValidator,
    viewRolePermissions
);

// PUT /v1/rbac/roles/:id/permissions - Assign permissions to a specific role (requires 'assign_role_permissions' permission)

/**
 * @openapi
 * /v1/roles/{id}/permissions:
 *   put:
 *     summary: Assign permissions to role
 *     tags: [Roles]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               permissionIds:
 *                 type: array
 *                 items:
 *                   type: integer
 *                 example: [1,2,3]
 *     responses:
 *       200:
 *         description: Permissions assigned
 */
router.put(
    '/:id/permissions',
    verifyAccessToken,
    checkPermission("assign_role_permissions"), // Ensure this permission exists in your DB
    roleIdValidator,
    assignPermissionsValidator, // Validate the 'permissionIds' array in the request body
    assignPermissions
);


module.exports = router;