// src/config/swagger.js
const swaggerJsdoc = require("swagger-jsdoc");

const options = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "My Application API",
            version: "1.0.0",
            description: "API documentation for My Application Backend",
        },
        servers: [
            {
                url: `http://localhost:3000`,
                description: "Development server",
            },
        ],
        components: {
            securitySchemes: {
                BearerAuth: {
                    type: "http",
                    scheme: "bearer",
                    bearerFormat: "JWT"
                }
            }
        }
    },
    apis: ["./src/modules/**/*.js"],
};

const specs = swaggerJsdoc(options);

module.exports = specs;