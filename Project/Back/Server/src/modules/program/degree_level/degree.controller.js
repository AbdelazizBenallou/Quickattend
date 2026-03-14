// src/modules/program/degree_level/degree.controller.js
const { getAllDegrees, getDegreeById } = require('./degree.service');
const response = require('../../../utils/response');

async function viewDegrees(req, res) {
    try {
        const degrees = await getAllDegrees();

        if (!degrees || degrees.length === 0) {
            return response.error(res, "No degrees found", 404);
        }

        return response.success(res, degrees, "Degrees fetched successfully");
    } catch (err) {
        console.error('View degrees error:', err.message);
        return response.error(res, "Failed to fetch degrees", 500);
    }
}

async function viewDegree(req, res) {
    try {
        const { id } = req.params;
        const degree = await getDegreeById(Number(id));

        return response.success(res, degree, "Degree fetched successfully");
    } catch (err) {
        if (err.message === 'Degree not found') {
            return response.error(res, "Degree not found", 404);
        }
        console.error('View degree error:', err.message);
        return response.error(res, "Failed to fetch degree", 500);
    }
}

module.exports = {
    viewDegrees,
    viewDegree
};