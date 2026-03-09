const prisma = require("../config/prisma");

async function getUserPermissions(userId) {

    const roles = await prisma.user_role.findMany({
        where: { user_id: userId },
        include: {
            role: {
                include: {
                    role_permission: {
                        include: {
                            permission: true
                        }
                    }
                }
            }
        }
    });

    const permissions = [];

    roles.forEach(r => {
        r.role.role_permission.forEach(p => {
            permissions.push(p.permission.name);
        });
    });

    return permissions;
}

module.exports = getUserPermissions;