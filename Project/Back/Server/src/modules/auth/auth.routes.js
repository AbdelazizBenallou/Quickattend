const express = require('express');
const router = express.Router();
const prisma = require("../../config/prisma");
const { login } = require('./auth.controller');
const { loginValidationRules, validateLogin } = require('./auth.validator');

/* Rate limiter for auth routes */

/** Auth Routes **/
/* Post /v1/auth/login */

router.post('/login', loginValidationRules(), validateLogin, login);
/* Post /v1/auth/register */


/* Post /v1/auth/logout */


/* Post /v1/auth/refresh-token */

module.exports = router;


