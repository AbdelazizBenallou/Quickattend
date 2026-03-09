
require('dotenv').config();
const express = require("express");
//const path = require('path');


const swaggerUi = require('swagger-ui-express');
const swaggerSpecs = require('./src/config/swagger');

const authRoutes = require("./src/modules/auth/auth.routes");
const userRoutes = require("./src/modules/users/users.routes");
const roleRoutes = require("./src/modules/rbac/role/role.route"); // تأكد من استيراد مسارات الأدوار


const errorHandler = require('./src/middleware/errorHandler');
const { PORT } = require('./src/config/env');

const app = express();


app.use(express.json());


app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpecs));


app.use("/v1/auth", authRoutes);
app.use("/v1/users", userRoutes);
app.use("/v1/roles", roleRoutes); 

app.use(errorHandler);


app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Swagger UI available at http://localhost:${PORT}/api-docs`);
});