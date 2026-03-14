// src/modules/program/degree_level/degree.validator.js
const { param } = require('express-validator');

const degreeIdValidator = [
    param("id")
        .exists().withMessage("Degree ID is required")
        .bail()
        .isInt({ min: 1 }).withMessage("Degree ID must be a positive integer")
];

module.exports = {
    degreeIdValidator
};