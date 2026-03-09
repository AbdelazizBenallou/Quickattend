const {
    getAllRoles,
    getRoleById,
    createRole,
    updateRole,
    deleteRole,
    getRolePermissions,
    assignPermissionsToRole
} = require('./role.service');
const response = require('../../../utils/response');

async function viewRoles(req, res) {
    try {
        const roles = await getAllRoles();

        if (!roles.length) {
            return response.error(res, "No roles found", 404);
        }
        return response.success(res, roles, "Roles fetched");
    } catch (err) {
        console.error('View roles error:', err.message);
        return response.error(res, "Failed to fetch roles", 500);
    }
}

async function viewRole(req, res) {
    try {
        const { id } = req.params;
        const role = await getRoleById(Number(id));
        // 'role' will be an object or throw an error if not found
        return response.success(res, role, "Role fetched");
    } catch (err) {
        if (err.message === 'Role not found') {
            return response.error(res, "Role not found", 404);
        }
        console.error('View role error:', err.message);
        return response.error(res, "Failed to fetch role", 500);
    }
}

async function create(req, res) {
    try {
        const { name } = req.body;
        const newRole = await createRole(name);
        return response.success(res, newRole, "Role created successfully", 201);
    } catch (err) {
        if (err.message === 'Role name already exists') {
            return response.error(res, "Role name already exists", 409);
        }
        console.error('Create role error:', err.message);
        return response.error(res, "Failed to create role", 500);
    }
}

async function update(req, res) {
    try {
        const { id } = req.params;
        const { name } = req.body;
        const updatedRole = await updateRole(Number(id), name);
        return response.success(res, updatedRole, "Role updated successfully");
    } catch (err) {
        if (err.message === 'Role not found') {
            return response.error(res, "Role not found", 404);
        } else if (err.message === 'New role name already exists') {
            return response.error(res, "New role name already exists", 409);
        }
        console.error('Update role error:', err.message);
        return response.error(res, "Failed to update role", 500);
    }
}

async function remove(req, res) {
    try {
        const { id } = req.params;
        await deleteRole(Number(id));
        return response.success(res, null, "Role deleted successfully");
    } catch (err) {
        if (err.message === 'Role not found') {
            return response.error(res, "Role not found", 404);
        }
        console.error('Delete role error:', err.message);
        return response.error(res, "Failed to delete role", 500);
    }
}

async function viewRolePermissions(req, res) {
    try {
        const { id } = req.params;
        const permissions = await getRolePermissions(Number(id));
        return response.success(res, permissions, "Permissions for role fetched");
    } catch (err) {
        if (err.message === 'Role not found') {
            return response.error(res, "Role not found", 404);
        }
        console.error('View role permissions error:', err.message);
        return response.error(res, "Failed to fetch permissions for role", 500);
    }
}

async function assignPermissions(req, res) {
    try {
        const { id } = req.params;
        const { permissionIds } = req.body; 
        await assignPermissionsToRole(Number(id), permissionIds);
        return response.success(res, null, "Permissions assigned to role successfully");
    } catch (err) {
        if (err.message === 'Role not found') {
            return response.error(res, "Role not found", 404);
        }
        console.error('Assign permissions error:', err.message);
        return response.error(res, "Failed to assign permissions to role", 500);
    }
}


module.exports = {
    viewRoles,
    viewRole,
    create,
    update,
    remove,
    viewRolePermissions,
    assignPermissions
};