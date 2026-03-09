const { body, param, query } = require('express-validator');

const roleIdValidator = [
  param("id")
    .exists().withMessage("Role ID is required")
    .bail()
    .isInt({ min: 1 }).withMessage("Role ID must be a positive integer")
];

const roleNameValidator = [
  body('name')
    .trim()
    .notEmpty().withMessage('Role name is required')
    .bail()
    .isLength({ max: 255 }).withMessage('Role name cannot exceed 255 characters')
    .bail()
    .matches(/^[a-z]+$/).withMessage('Role name can only contain lowercase letters')
];

const assignPermissionsValidator = [
    body('permissionIds') 
      .isArray({ min: 0 }) 
      .withMessage('permissionIds must be an array of integers.'),
    body('permissionIds.*')
      .isInt({ min: 1 }).withMessage('Each permission ID must be a positive integer.')
  ];

module.exports = {
  roleIdValidator,
  roleNameValidator,
  assignPermissionsValidator
};
