const prisma = require('../../config/prisma');

async function getAllUsers() {
    return prisma.users.findMany({
        select: {
            user_id: true,
            email: true,
            status: true,
            created_at: true
        }
    });
}

module.exports = { getAllUsers };