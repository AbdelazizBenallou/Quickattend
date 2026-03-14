const { param, body } = require("express-validator");

const userIdValidator = [
  param("id")
    .exists().withMessage("User ID is required")
    .bail()
    .isInt({ min: 1 }).withMessage("User ID must be a positive integer")
];

const updateProfileValidator = [
  body('first_name')
    .optional()
    .trim()
    .isLength({ min: 2, max: 50 }).withMessage('First name must be between 2 and 50 characters'),

  body('last_name')
    .optional()
    .trim()
    .isLength({ min: 2, max: 50 }).withMessage('Last name must be between 2 and 50 characters'),

  body('date_birth')
    .optional({ nullable: true }) 
    .bail()
    .isISO8601({ strict: true }) // Enforces strict YYYY-MM-DD or full ISO format
    .withMessage('Date of birth must be a valid ISO-8601 date (e.g., 1995-12-31)')
    .toDate(),

  body('address')
    .optional()
    .trim()
    .isLength({ max: 255 }).withMessage('Address cannot exceed 255 characters'),

  body('level_id')
    .optional()
    .isInt({ min: 1 }).withMessage('Level ID must be a positive integer'),

  body('specialization_id')
    .optional()
    .isInt({ min: 1 }).withMessage('Specialization ID must be a positive integer')
];

module.exports = {
  userIdValidator,
  updateProfileValidator
};