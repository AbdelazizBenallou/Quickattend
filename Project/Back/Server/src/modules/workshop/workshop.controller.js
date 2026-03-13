// src/modules/workshop/workshop.controller.js
const {
  getAllWorkshops,
  getWorkshopById,
  createWorkshop,
  updateWorkshop,
  deleteWorkshop,
  getWorkshopMembers,
  getWorkshopLeaders,
  getWorkshopClasses
} = require('./workshop.service');
const response = require('../../utils/response');

async function viewWorkshops(req, res) {
  try {
    const workshops = await getAllWorkshops();
    if (!workshops.length) {
      return response.error(res, "No workshops found", 404);
    }
    return response.success(res, workshops, "Workshops fetched");
  } catch (err) {
    console.error('View workshops error:', err.message);
    return response.error(res, "Failed to fetch workshops", 500);
  }
}

async function viewWorkshop(req, res) {
  try {
    const { id } = req.params;
    const workshop = await getWorkshopById(Number(id));
    return response.success(res, workshop, "Workshop fetched");
  } catch (err) {
    if (err.message === 'Workshop not found') {
      return response.error(res, "Workshop not found", 404);
    }
    console.error('View workshop error:', err.message);
    return response.error(res, "Failed to fetch workshop", 500);
  }
}

async function create(req, res) {
  try {
    const { name, leader_user_id } = req.body;
    const newWorkshop = await createWorkshop(name, leader_user_id);
    return response.success(res, newWorkshop, "Workshop created successfully", 201);
  } catch (err) {
    if (err.message === 'Workshop name already exists') {
      return response.error(res, "Workshop name already exists", 409);
    }
    console.error('Create workshop error:', err.message);
    return response.error(res, "Failed to create workshop", 500);
  }
}

async function update(req, res) {
  try {
    const { id } = req.params;
    const { name, leader_user_id } = req.body;
    const updatedWorkshop = await updateWorkshop(Number(id), name, leader_user_id);
    return response.success(res, updatedWorkshop, "Workshop updated successfully");
  } catch (err) {
    if (err.message === 'Workshop not found') {
      return response.error(res, "Workshop not found", 404);
    } else if (err.message === 'Workshop name already exists') {
      return response.error(res, "Workshop name already exists", 409);
    }
    console.error('Update workshop error:', err.message);
    return response.error(res, "Failed to update workshop", 500);
  }
}

async function remove(req, res) {
  try {
    const { id } = req.params;
    await deleteWorkshop(Number(id));
    return response.success(res, null, "Workshop deleted successfully");
  } catch (err) {
    if (err.message === 'Workshop not found') {
      return response.error(res, "Workshop not found", 404);
    }
    console.error('Delete workshop error:', err.message);
    return response.error(res, "Failed to delete workshop", 500);
  }
}

async function viewMembers(req, res) {
  try {
    const { id } = req.params;
    const members = await getWorkshopMembers(Number(id));
    return response.success(res, members, "Workshop members fetched");
  } catch (err) {
    if (err.message === 'Workshop not found') {
      return response.error(res, "Workshop not found", 404);
    }
    console.error('View members error:', err.message);
    return response.error(res, "Failed to fetch members", 500);
  }
}

async function viewLeaders(req, res) {
  try {
    const { id } = req.params;
    const leaders = await getWorkshopLeaders(Number(id));
    return response.success(res, leaders, "Workshop leaders fetched");
  } catch (err) {
    if (err.message === 'Workshop not found') {
      return response.error(res, "Workshop not found", 404);
    }
    console.error('View leaders error:', err.message);
    return response.error(res, "Failed to fetch leaders", 500);
  }
}

async function viewClasses(req, res) {
  try {
    const { id } = req.params;
    const classes = await getWorkshopClasses(Number(id));
    return response.success(res, classes, "Workshop classes fetched");
  } catch (err) {
    if (err.message === 'Workshop not found') {
      return response.error(res, "Workshop not found", 404);
    }
    console.error('View classes error:', err.message);
    return response.error(res, "Failed to fetch classes", 500);
  }
}

module.exports = {
  viewWorkshops,
  viewWorkshop,
  create,
  update,
  remove,
  viewMembers,
  viewLeaders,
  viewClasses
};