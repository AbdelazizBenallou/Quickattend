const { getAllUsers, getUserById,  deleteUserById } = require('./users.service');
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

module.exports = { viewUsers, viewUser, deleteUser };