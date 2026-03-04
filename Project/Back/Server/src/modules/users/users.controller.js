const { getAllUsers } = require('./users.service');
const response = require('../../utils/response');

async function viewUsers(req, res) {
    const users = await getAllUsers();

    if (!users.length) {
        return response.error(res, "No users found", 404);
    }

    return response.success(res, users, "Users fetched");
}

module.exports = { viewUsers };