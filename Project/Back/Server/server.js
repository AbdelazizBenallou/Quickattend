require('dotenv').config();

const express = require("express");
const authRoutes = require("./src/modules/auth/auth.routes");
const userRoutes = require("./src/modules/users/users.routes");
const errorHandler = require('./src/middleware/errorHandler');
const originCheck = require('./src/middleware/originCheck');
const { PORT } = require('./src/config/env');

const app = express();

app.use(express.json());

app.use("/v1/auth", authRoutes);
app.use("/v1/users", userRoutes);

app.use(errorHandler);
//app.use(originCheck);

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});