const express = require('express');
const router = express.Router();
const prisma = require("../../config/prisma");



/* Rate limiter for auth routes */

/** Auth Routes **/
/* Post /v1/auth/login */


router.get("/test", async (req, res) => {
    let userId = 3;
    try {
        const users = await prisma.users.findUnique({
            where: { user_id: userId },
            select: {
                user_id: true,
                full_name: true,
                email: true,
                created_at: true
            }
        }
        );
        res.json(users);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Database error" });
    }
});


/* Post /v1/auth/register */


/* Post /v1/auth/logout */


/* Post /v1/auth/refresh-token */

module.exports = router;


