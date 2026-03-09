const { body, validationResult } = require('express-validator');

const loginValidationRules = () => {
  return [
    body('email')
      .isEmail()
      .normalizeEmail(),

    body('password')
      .notEmpty()
      .isLength({ min: 6 })
  ]
};

const validateLogin = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: 'Invalid login credentials' });
  }
  next();
};


const registerValidationRules = () => {
  return [
    body('email')
      .isEmail()
      .withMessage('Invalid email')
      .normalizeEmail(),

    body('password')
      .isLength({ min: 6 })
      .withMessage('Password must be at least 6 characters'),

    body('first_name')
      .trim()
      .notEmpty().withMessage('First name is required')
      .bail()
      .isLength({ min: 4 }).withMessage('First name must be at least 4 characters')
      .bail()
      .matches(/^[A-Za-z]+$/).withMessage('First name must contain only letters')
      .bail()
      ,

    body('last_name')
      .trim()
      .notEmpty().withMessage('Last name is required')
      .bail()
      .isLength({ min: 4 }).withMessage('Last name must be at least 4 characters')
      .bail()
      .matches(/^[A-Za-z]+$/).withMessage('Last name must contain only letters')
      .bail()
  ];
};

const validateRegistration = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: 'Invalid registration data' });
  }
  next();
};


module.exports = {
  loginValidationRules,
  validateLogin,
  registerValidationRules,
  validateRegistration
};

