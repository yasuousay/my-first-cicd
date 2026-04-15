const express = require('express');
const cors = require('cors');
const promClient = require('prom-client');

const app = express();
app.use(cors());
app.use(express.json());

// Tạo registry
const register = new promClient.Registry();
// Thêm default metrics (CPU, memory, etc.)
promClient.collectDefaultMetrics({ register });

// Tạo custom metric
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.1, 0.5, 1, 2, 5]
});
register.registerMetric(httpRequestDuration);

// Middleware track requests
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = (Date.now() - start) / 1000;
    httpRequestDuration.labels(req.method, req.route?.path || req.path, res.statusCode).observe(duration);
  });
  next();
});

// Endpoint metrics
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.send(await register.metrics());
});

app.get("/api", (req, res) => {
  res.json({ status: "ok", message: "Hello from backend! 🐳" });
});

app.get("/api/health", (req, res) => {
  res.json({ status: "healthy", uptime: process.uptime() });
});

app.get('/api/hello', (req, res) => {
  res.json({ message: "Hello từ AWS EC2 Backend!" });
});

app.listen(3000, () => {
  console.log("Backend running on port 3000 🚀");
});