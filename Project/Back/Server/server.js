const express = require("express");
const authRoutes = require("./src/modules/auth/auth.routes");

const app = express();
app.use(express.json());

app.get("/hello", (req, res) => {
  res.json({ message: "Hello World 👋" });
});

app.post("/sum", (req, res) => {
  const { a, b } = req.body;

  const numA = parseFloat(a);
  const numB = parseFloat(b);

  if (isNaN(numA) || isNaN(numB)) {
    return res.status(400).json({ error: "Invalid numbers" });
  }

  res.json({ result: numA + numB });
});

app.use("/v1/auth", authRoutes);

app.listen(3000,'0.0.0.0', () => {
  console.log("Server running on port 3000");
});