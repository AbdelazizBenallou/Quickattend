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

async function getUserById(id) {

    const user = await prisma.users.findUnique({
        where: { user_id: id },
        select: {
            user_id: true,
            email: true,
            status: true,
            created_at: true
        }
    });

    if (!user) {
        throw new Error('Invalid User ID');
    }

    const userRoles = await prisma.user_role.findMany({
        where: { user_id: user.user_id },
        select: {
            role: {
                select: {
                    name: true
                }
            }
        }
    });

    const roles = userRoles.map(r => r.role.name);

    return {
        ...user,
        roles
    };
}

async function deleteUserById(id) {

    const user = await prisma.users.findUnique({
        where: { user_id: id }
    });
    if (!user) {
        throw new Error("User not found");
    }
    await prisma.users.delete({
        where: { user_id: id }
    });

    return true;
}

module.exports = { getAllUsers, getUserById, deleteUserById };