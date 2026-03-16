// src/modules/program/specialization/specialization.validator.js
const { param } = require('express-validator');

const specializationIdValidator = [
    param('id')
        .exists().withMessage('Specialization ID is required')
        .bail()
        .isInt({ min: 1 }).withMessage('Specialization ID must be a positive integer')
];

module.exports = {
    specializationIdValidator
};