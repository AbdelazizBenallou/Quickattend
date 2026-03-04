const express = require("express");
const router = express.Router();
const { viewUsers } = require("./users.controller");
const checkPermission = require("../../middleware/checkPermission");

router.get(
  "/users",
  checkPermission("view_users"),
  viewUsers
);

module.exports = router;