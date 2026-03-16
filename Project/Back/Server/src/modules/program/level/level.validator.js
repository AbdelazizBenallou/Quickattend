// src/modules/program/level/level.validator.js
const { param } = require('express-validator');

const levelIdValidator = [
    param('id')
        .exists().withMessage('Level ID is required')
        .bail()
        .isInt({ min: 1 }).withMessage('Level ID must be a positive integer')
];

module.exports = {
    levelIdValidator
};