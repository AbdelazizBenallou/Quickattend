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

async function updateUserProfile(userId, updates) {
    // 1. Check if User Exists and is Active
    const user = await prisma.users.findUnique({
        where: { user_id: userId },
        select: { user_id: true, status: true }
    });

    if (!user) {
        throw new Error('User not found');
    }
    console.log(user.user_id);

    if (user.status !== 'active') {
        throw new Error('Cannot update profile: User account is not active');
    }

    if (updates.level_id) {
        const levelExists = await prisma.level.findUnique({
            where: { level_id: updates.level_id },
            select: { level_id: true }
        });
        if (!levelExists) {
            throw new Error('Invalid Level ID provided');
        }
    }
    
    if (updates.specialization_id) {
        const specExists = await prisma.specialization.findUnique({
            where: { specialization_id: updates.specialization_id },
            select: { specialization_id: true }
        });
        if (!specExists) {
            throw new Error('Invalid Specialization ID provided');
        }
    }


    const updatedProfile = await prisma.profile.update({
        where: { user_id: userId },
        data: updates,
        include: {
            level: { select: { name: true } },
            specialization: { select: { name: true } }
        }
    });

    return updatedProfile;
}
module.exports = { getAllUsers, getUserById, deleteUserById, updateUserProfile };