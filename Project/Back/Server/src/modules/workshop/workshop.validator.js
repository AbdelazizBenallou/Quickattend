// src/modules/workshop/workshop.validator.js
const { body, param } = require('express-validator');

const workshopIdValidator = [
  param("id")
    .exists().withMessage("Workshop ID is required")
    .bail()
    .isInt({ min: 1 }).withMessage("Workshop ID must be a positive integer")
];

const workshopBodyValidator = [
  body('name')
    .trim()
    .notEmpty().withMessage('Workshop name is required')
    .bail()
    .isLength({ max: 255 }).withMessage('Workshop name cannot exceed 255 characters'),
  body('leader_user_id')
    .optional()
    .isInt({ min: 1 }).withMessage('Leader user ID must be a positive integer')
];

module.exports = {
  workshopIdValidator,
  workshopBodyValidator
};