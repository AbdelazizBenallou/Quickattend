const response = require('../utils/response');
const { NODE_ENV } = require('../config/env');

const errorHandler = (err, req, res, next) => {
    const isDev = NODE_ENV === "dev";
    const statusCode = err.statusCode || 500;
    const message = statusCode === 500 ? "Something went wrong" : err.message;

    return response.error(res, message, statusCode);
};

module.exports = errorHandler;