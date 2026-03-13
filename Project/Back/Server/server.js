
require('dotenv').config();
const express = require("express");
//const path = require('path');
//const origin = require('./src/middleware/originCheck')

const swaggerUi = require('swagger-ui-express');
const swaggerSpecs = require('./src/config/swagger');
const cors = require('cors')
const originCheck = require('./src/middleware/originCheck');
const cookieParser = require('cookie-parser');

const authRoutes = require("./src/modules/auth/auth.routes");
const userRoutes = require("./src/modules/users/users.routes");
const roleRoutes = require("./src/modules/rbac/role/role.route");
const workshopRoutes = require("./src/modules/workshop/workshop.routes");

//const errorHandler = require('./src/middleware/errorHandler');
const { PORT } = require('./src/config/env');

const app = express();
app.use(cookieParser()); 
app.use(express.json());

//app.use(originCheck);

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpecs));


app.use("/v1/auth", authRoutes);
app.use("/v1/users", userRoutes);
app.use("/v1/roles", roleRoutes);
app.use("/v1/workshops", workshopRoutes);
//app.use(errorHandler);


app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT} `);
  console.log(`Swagger UI available at http://localhost:5434/api-docs`);
});