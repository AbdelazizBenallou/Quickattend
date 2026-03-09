const { param } = require("express-validator");

const userIdValidator = [
  param("id")
    .exists().withMessage("User ID is required")
    .bail()
    .isInt({ min: 1 }).withMessage("User ID must be a positive integer")
];

module.exports = { userIdValidator };