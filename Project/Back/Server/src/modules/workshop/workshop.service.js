// src/modules/workshop/workshop.service.js
const prisma = require('../../config/prisma');

async function getAllWorkshops() {
    return prisma.workshop.findMany({
        select: {
            workshop_id: true,
            name: true,
            created_at: true,
            leader_user_id: true
        }
    });
}

async function getWorkshopById(id) {
    const workshop = await prisma.workshop.findUnique({
        where: { workshop_id: id },
        include: {
            users: {
                select: {
                    user_id: true,
                    email: true,
                    status: true,
                    profile: {
                        select: {
                            first_name: true,
                            last_name: true
                        }
                    }
                }
            } // Includes the leader based on schema relation
        }
    });
    if (!workshop) {
        throw new Error('Workshop not found');
    }
    return workshop;
}

async function createWorkshop(name, leaderUserId) {

    try {

        const user = await prisma.users.findUnique({
            where: { user_id: leaderUserId },
            include: {
                user_role: {
                    include: {
                        role: true
                    }
                }
            }
        });

        if (!user) {
            throw new Error("Leader user not found");
        }

        if (user.status !== "active") {
            throw new Error("Leader account is not active");
        }
        console.log(user.status);

        const roles = user.user_role.map(r => r.role.name);

        if (!roles.includes("WorkShop_Leader")) {
            throw new Error("User must have WorkshopLeader role");
        }

        const workshop = await prisma.workshop.create({
            data: {
                name,
                leader_user_id: leaderUserId
            }
        });

        return workshop;

    } catch (err) {

        if (err.code === "P2002") {
            throw new Error("Workshop name already exists");
        }
        throw err;
    }
}

async function updateWorkshop(id, name, leaderUserId) {
    try {
        const updatedWorkshop = await prisma.workshop.update({
            where: { workshop_id: id },
            data: {
                name,
                leader_user_id: leaderUserId
            }
        });
        return updatedWorkshop;
    } catch (err) {
        if (err.code === 'P2025') {
            throw new Error('Workshop not found');
        } else if (err.code === 'P2002') {
            throw new Error('Workshop name already exists');
        }
        throw err;
    }
}

async function deleteWorkshop(id) {
    const workshop = await prisma.workshop.findUnique({
        where: { workshop_id: id }
    });
    if (!workshop) {
        throw new Error("Workshop not found");
    }
    await prisma.workshop.delete({
        where: { workshop_id: id }
    });
    return true;
}

async function getWorkshopMembers(workshopId) {
    const workshop = await prisma.workshop.findUnique({
        where: { workshop_id: workshopId }
    });
    if (!workshop) {
        throw new Error('Workshop not found');
    }
    const memberships = await prisma.user_workshop.findMany({
        where: { workshop_id: workshopId },
        include: {
            users: {
                select: {
                    user_id: true,
                    email: true,
                    status: true,
                    profile: {
                        select: {
                            first_name: true,
                            last_name: true
                        }
                    }
                }
            }
        }
    });

    return memberships.map(m => m.users);
}

async function getWorkshopLeaders(workshopId) {
    // 1. First, check if workshop exists
    const workshop = await prisma.workshop.findUnique({
        where: { workshop_id: workshopId }
    });

    if (!workshop) {
        throw new Error('Workshop not found');
    }

    if (!workshop.leader_user_id) {
        return [];
    }

    const leader = await prisma.users.findUnique({
        where: { user_id: workshop.leader_user_id },
        select: {
            user_id: true,
            email: true,
            status: true,
            profile: {
                select: {
                    first_name: true,
                    last_name: true
                }
            }
        }
    });

    return leader ? [leader] : [];
}

async function getWorkshopClasses(workshopId) {
    const workshop = await prisma.workshop.findUnique({
        where: { workshop_id: workshopId }
    });
    if (!workshop) {
        throw new Error('Workshop not found');
    }

    // Note: Model name is 'Renamedclass' due to schema introspection reservation
    const classes = await prisma.Renamedclass.findMany({
        where: { workshop_id: workshopId },
        select: {
            class_id: true,
            name: true,
            date: true,
            properties: true
        }
    });
    return classes;
}

module.exports = {
    getAllWorkshops,
    getWorkshopById,
    createWorkshop,
    updateWorkshop,
    deleteWorkshop,
    getWorkshopMembers,
    getWorkshopLeaders,
    getWorkshopClasses
};