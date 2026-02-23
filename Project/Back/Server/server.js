const express = require("express");
const authRoutes = require("./src/modules/auth/auth.routes");

const app = express();
app.use(express.json());

app.use("/v1/auth", authRoutes);

app.listen(3000,'0.0.0.0', () => {
  console.log("Server running on port 3000");
});