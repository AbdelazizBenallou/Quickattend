const errorHandler = (err, req, res, next) => {
    const [NODE_ENV] = require('../config/env')

    const isDev = NODE_ENV === "dev";

    const statusCode = err.statusCode || 500;

    const message =
        statusCode === 500
            ? "Something went wrong"
            : err.message;

    res.status(statusCode).json({
        success: false,
        message,
        ...(isDev && {
            errorCode: err.errorCode,
            stack: err.stack
        })
    });
};

module.exports = errorHandler;