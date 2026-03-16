// src/modules/program/specialization/specialization.controller.js
const { getAllSpecializations, getSpecializationById } = require('./specialization.service');
const response = require('../../../utils/response');

async function viewSpecializations(req, res) {
    try {
        const specializations = await getAllSpecializations();
        if (!specializations || specializations.length === 0) {
            return response.error(res, 'No specializations found', 404);
        }
        return response.success(res, specializations, 'Specializations fetched successfully');
    } catch (err) {
        console.error('View specializations error:', err.message);
        return response.error(res, 'Failed to fetch specializations', 500);
    }
}

async function viewSpecialization(req, res) {
    try {
        const { id } = req.params;
        const specialization = await getSpecializationById(Number(id));
        return response.success(res, specialization, 'Specialization fetched successfully');
    } catch (err) {
        if (err.message === 'Specialization not found') {
            return response.error(res, 'Specialization not found', 404);
        }
        console.error('View specialization error:', err.message);
        return response.error(res, 'Failed to fetch specialization', 500);
    }
}

module.exports = {
    viewSpecializations,
    viewSpecialization
};