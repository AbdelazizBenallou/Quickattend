const { getAllUsers, getUserById, deleteUserById, updateUserProfile } = require('./users.service');
const response = require('../../utils/response');

async function viewUsers(req, res) {
    const users = await getAllUsers();
    if (!users.length) {
        return response.error(res, "No users found", 404);
    }

    return response.success(res, users, "Users fetched");
}

async function viewUser(req, res) {
    try {
        const { id } = req.params;
        const user = await getUserById(Number(id));

        return response.success(res, user, "User fetched");
    } catch (err) {
        return response.error(res, "Not Found", 404);
    }
}

async function deleteUser(req, res) {

    try {
        const { id } = req.params;
        await deleteUserById(Number(id));
        return response.success(res, null, "User deleted");

    } catch (err) {
        return response.error(res, "User not found", 404);
    }

}

async function updateProfile(req, res) {
    try {

        const targetUserId = Number(req.params.id);

        if (!targetUserId || isNaN(targetUserId)) {
            return response.error(res, "Invalid User ID provided", 400);
        }
        
        const updates = req.body;
        const cleanUpdates = {};
        const allowedFields = ['first_name', 'last_name', 'date_birth', 'address', 'level_id', 'specialization_id'];

        allowedFields.forEach(field => {
            if (updates[field] !== undefined) {
                cleanUpdates[field] = updates[field];
            }
        });

        if (Object.keys(cleanUpdates).length === 0) {
            return response.error(res, "No valid fields to update", 400);
        }

        const updatedProfile = await updateUserProfile(targetUserId, cleanUpdates);

        return response.success(res, updatedProfile, "Profile updated successfully");
    } catch (err) {
        console.error('Update profile error:', err.message);

        if (err.message === 'User not found') {
            return response.error(res, "User not found", 404);
        }
        if (err.message.includes('not active')) {
            return response.error(res, 'Forbidden', 403);
        }
        if (err.message.includes('Invalid Level') || err.message.includes('Invalid Specialization')) {
            return response.error(res, 'Invalid level or specialization', 400);
        }

        return response.error(res, "Failed to update profile", 500);
    }
}


module.exports = { viewUsers, viewUser, deleteUser, updateProfile };