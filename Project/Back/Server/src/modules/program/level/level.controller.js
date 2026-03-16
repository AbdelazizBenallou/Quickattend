// src/modules/program/level/level.controller.js
const { getAllLevels, getLevelById } = require('./level.service');
const response = require('../../../utils/response');

async function viewLevels(req, res) {
    try {
        const levels = await getAllLevels();
        if (!levels || levels.length === 0) {
            return response.error(res, 'No levels found', 404);
        }
        return response.success(res, levels, 'Levels fetched successfully');
    } catch (err) {
        console.error('View levels error:', err.message);
        return response.error(res, 'Failed to fetch levels', 500);
    }
}

async function viewLevel(req, res) {
    try {
        const { id } = req.params;
        const level = await getLevelById(Number(id));
        return response.success(res, level, 'Level fetched successfully');
    } catch (err) {
        if (err.message === 'Level not found') {
            return response.error(res, 'Level not found', 404);
        }
        console.error('View level error:', err.message);
        return response.error(res, 'Failed to fetch level', 500);
    }
}

module.exports = {
    viewLevels,
    viewLevel
};