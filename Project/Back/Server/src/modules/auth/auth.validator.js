const { body, validationResult } = require('express-validator');

const loginValidationRules = () => {
  return [
    body('email').isEmail().normalizeEmail(),
    body('password').notEmpty().isLength({ min: 6 })
  ];
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
    body('email').isEmail().normalizeEmail(),
    body('password').isLength({ min: 6 }),
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

