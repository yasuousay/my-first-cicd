const express = require("express");
const app = express();
app.get("/api", (req, res) => {
  res.json({ status: "ok", message: "Hello from backend! 🐳" });
});

app.get("/api/health", (req, res) => {
  res.json({ status: "healthy", uptime: process.uptime() });
});

app.listen(8080, () => {
  console.log("Backend running on port 8080 🚀");
});