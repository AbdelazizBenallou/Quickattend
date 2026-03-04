const requiredEnv = [
    'DATABASE_URL',
    'ACCESS_SECRET',
    'REFRESH_SECRET',
];

requiredEnv.forEach((key) => {
    if (!process.env[key]) {
        throw new Error(`Missing environment variable: ${key}`);
    }
});

module.exports = {
    NODE_ENV: process.env.NODE_ENV,
    PORT: process.env.PORT || 5434,
    DATABASE_URL: process.env.DATABASE_URL,
    ACCESS_SECRET: process.env.ACCESS_SECRET,
    REFRESH_SECRET: process.env.REFRESH_SECRET,
};