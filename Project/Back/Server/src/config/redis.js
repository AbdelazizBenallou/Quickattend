const { createClient } = require("redis");

const redis = createClient({
  url: "redis://redis:6379"
});

redis.on("error", (err) => {
  console.error("Redis error:", err);
  process.exit(1);
});

process.on('SIGINT', async () => {
  await redis.quit();
  process.exit(0);
});

(async () => {
  await redis.connect();
  console.log("Redis connected");
})();

module.exports = redis;
