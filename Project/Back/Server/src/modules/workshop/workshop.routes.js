// src/modules/workshop/workshop.routes.js
const express = require("express");
const router = express.Router();
const {
  viewWorkshops,
  viewWorkshop,
  create,
  update,
  remove,
  viewMembers,
  viewLeaders,
  viewClasses
} = require("./workshop.controller");
const { workshopIdValidator, workshopBodyValidator } = require('./workshop.validator');
const checkPermission = require("../../middleware/checkPermission");
const verifyAccessToken = require('../../middleware/verifyAccessToken');

/* Workshop Management APIs */

// GET /v1/workshops - Fetch all workshops
/**
* @openapi
* tags:
*   name: Workshops
*   description: API endpoints for managing workshops
*/
/**
* @openapi
* /v1/workshops:
*   get:
*     summary: Get all workshops
*     tags: [Workshops]
*     security:
*       - BearerAuth: []
*     responses:
*       200:
*         description: List of workshops
*/
router.get(
  '/',
  verifyAccessToken,
  checkPermission("view_workshops"),
  viewWorkshops
);

// POST /v1/workshops - Create a new workshop
/**
* @openapi
* /v1/workshops:
*   post:
*     summary: Create a new workshop
*     tags: [Workshops]
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
*                 example: "Advanced Java"
*               leader_user_id:
*                 type: integer
*                 example: 1
*     responses:
*       201:
*         description: Workshop created successfully
*       409:
*         description: Workshop name already exists
*/
router.post(
  '/',
  verifyAccessToken,
  checkPermission("create_workshop"),
  workshopBodyValidator,
  create
);

// GET /v1/workshops/:id - Get workshop by ID
/**
* @openapi
* /v1/workshops/{id}:
*   get:
*     summary: Get workshop by ID
*     tags: [Workshops]
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
*         description: Workshop fetched
*       404:
*         description: Workshop not found
*/
router.get(
  '/:id',
  verifyAccessToken,
  checkPermission("view_workshop"),
  workshopIdValidator,
  viewWorkshop
);

// PUT /v1/workshops/:id - Update workshop
/**
* @openapi
* /v1/workshops/{id}:
*   put:
*     summary: Update workshop
*     tags: [Workshops]
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
*               leader_user_id:
*                 type: integer
*     responses:
*       200:
*         description: Workshop updated
*       404:
*         description: Workshop not found
*/
router.put(
  '/:id',
  verifyAccessToken,
  checkPermission("update_workshop"),
  workshopIdValidator,
  workshopBodyValidator,
  update
);

// DELETE /v1/workshops/:id - Delete workshop
/**
* @openapi
* /v1/workshops/{id}:
*   delete:
*     summary: Delete workshop
*     tags: [Workshops]
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
*         description: Workshop deleted successfully
*       404:
*         description: Workshop not found
*/
router.delete(
  '/:id',
  verifyAccessToken,
  checkPermission("delete_workshop"),
  workshopIdValidator,
  remove
);

// GET /v1/workshops/:id/members - Get members
/**
* @openapi
* /v1/workshops/{id}/members:
*   get:
*     summary: Get all members of workshop
*     tags: [Workshops]
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
*         description: List of members
*/
router.get(
  '/:id/members',
  verifyAccessToken,
  checkPermission("view_workshop_members"),
  workshopIdValidator,
  viewMembers
);

// GET /v1/workshops/:id/leaders - Get leaders
/**
* @openapi
* /v1/workshops/{id}/leaders:
*   get:
*     summary: Get leaders of workshop
*     tags: [Workshops]
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
*         description: List of leaders
*/
router.get(
  '/:id/leaders',
  verifyAccessToken,
  checkPermission("view_workshop_leaders"),
  workshopIdValidator,
  viewLeaders
);

// GET /v1/workshops/:id/classes - Get classes
/**
* @openapi
* /v1/workshops/{id}/classes:
*   get:
*     summary: Get all classes in workshop
*     tags: [Workshops]
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
*         description: List of classes
*/
router.get(
  '/:id/classes',
  verifyAccessToken,
  checkPermission("view_workshop_classes"),
  workshopIdValidator,
  viewClasses
);

module.exports = router;    