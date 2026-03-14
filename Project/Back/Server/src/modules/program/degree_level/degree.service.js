// src/modules/program/degree_level/degree.service.js
const prisma = require('../../../config/prisma');

async function getAllDegrees() {
    return prisma.degree_level.findMany({
        select: {
            degree_level_id: true,
            name: true,
        }
    });
}

async function getDegreeById(id) {
    const degree = await prisma.degree_level.findUnique({
        where: { degree_level_id: id },
        select: {
            degree_level_id: true,
            name: true,
        }
    });

    if (!degree) {
        throw new Error('Degree not found');
    }

    return degree;
}

module.exports = {
    getAllDegrees,
    getDegreeById
};