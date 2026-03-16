// server.js
require('dotenv').config();
const express = require("express");
const cookieParser = require('cookie-parser'); // Used later
const cors = require('cors'); // Used later, if needed

const { PORT } = require('./src/config/env');

const app = express();

// --- CRITICAL MIDDLEWARE MUST BE HERE ---
app.use(cors()); // Apply CORS if needed
app.use(cookieParser()); // Parse cookies from requests
app.use(express.json());
// ----------------------------------------

// Swagger setup (if applicable)
const swaggerUi = require('swagger-ui-express');
const swaggerSpecs = require('./src/config/swagger');
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpecs));

const authRoutes = require("./src/modules/auth/auth.routes");
const userRoutes = require("./src/modules/users/users.routes");
const degreeRoutes = require("./src/modules/program/degree_level/degree.route")
// ... import other route modules as needed

app.use("/v1/auth", authRoutes); 
app.use("/v1/users", userRoutes);
app.use("/v1/degree", degreeRoutes);



const errorHandler = require('./src/middleware/errorHandler');
app.use(errorHandler); 

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT} `);
    console.log(`Swagger UI available at http://localhost:${PORT}/api-docs`);
});
