const send = (res, statusCode, success, message, data = null, meta = null) => {
    const response = {
        success,
        message,
    };

    if (data !== null) response.data = data;
    if (meta !== null) response.meta = meta;

    return res.status(statusCode).json(response);
};

const response = {
    success: (res, data = {}, message = "Success", statusCode = 200) =>
        send(res, statusCode, true, message, data),

    error: (res, message = "Something went wrong", statusCode = 500) =>
        send(res, statusCode, false, message),
};

module.exports = response;