// src/modules/rbac/role/role.service.js
const prisma = require('../../../config/prisma');

async function getAllRoles() {
  return prisma.role.findMany({
    select: {
      role_id:true,
      name: true,
    }
  });
}

async function getRoleById(id) {
  const role = await prisma.role.findUnique({
    where: { role_id: id }
  });
  
  if (!role) {
    throw new Error('Role not found');
  }
  return role;
}

async function createRole(name) {
  try {
    const newRole = await prisma.role.create({
      data: {
        name },
    });
    return newRole;
  } catch (err) {
    if (err.code === 'P2002') { 
      throw new Error('Role name already exists');
    }
    throw err;
  }
}


async function updateRole(id, newName) {
  try {
    const updatedRole = await prisma.role.update({
      where: { role_id: id },
      data: {
        name: newName,
      },
    });
    return updatedRole;
  } catch (err) {
    if (err.code === 'P2025') { 
      throw new Error('Role not found');
    } else if (err.code === 'P2002') { 
      throw new Error('New role name already exists');
    }
    throw err;
  }
}

async function deleteRole(id) {
  const role = await prisma.role.findUnique({
    where: { role_id: id }
  });

  if (!role) {
    throw new Error("Role not found");
  }

  await prisma.role.delete({
    where: { role_id: id }
  });

  return true;
}

async function getRolePermissions(roleId) {
  const role = await prisma.role.findUnique({
    where: { role_id: roleId },
    include: {
      role_permission: {
        include: {
          permission: true
        }
      }
    }
  });

  if (!role) {
    throw new Error('Role not found');
  }

  return role.role_permission.map(rp => rp.permission);
}

async function assignPermissionsToRole(roleId, permissionIds) {
  const role = await prisma.role.findUnique({
    where: { role_id: roleId }
  });

  if (!role) {
    throw new Error('Role not found');
  }

  // First, delete all existing permissions for this role
  await prisma.role_permission.deleteMany({
    where: { role_id: roleId }
  });

  // Then, create new permission assignments
  const newAssignments = permissionIds.map(permissionId => ({
    role_id: roleId,
    permission_id: permissionId
  }));

  if (newAssignments.length > 0) {
    await prisma.role_permission.createMany({
      data: newAssignments
    });
  }

}


module.exports = {
  getAllRoles,
  getRoleById,
  createRole,
  updateRole,
  deleteRole,
  getRolePermissions,
  assignPermissionsToRole
};
