const response = require("../utils/response")

const allowedOrigins = [
     "http://localhost:3000",
    "http://localhost:5434"

];

function originCheck(req, res, next) {
    const origin = req.headers.origin;
    if (!origin) return next();
    if (!allowedOrigins.includes(origin)) {
        return response.error(res, "Forbidden origin", 403);
    }
}

module.exports = originCheck;
