// src/modules/program/level/level.service.js
const prisma = require('../../../config/prisma');

async function getAllLevels() {
    return prisma.level.findMany({
        select: {
            level_id: true,
            name: true,
            degree_level: {
                select: {
                    degree_level_id: true,
                    name: true
                }
            }
        }
    });
}

async function getLevelById(id) {
    const level = await prisma.level.findUnique({
        where: { level_id: id },
        select: {
            level_id: true,
            name: true,
            created_at: true,
            degree_level: {
                select: {
                    degree_level_id: true,
                    name: true
                }
            },
        }
    });

    if (!level) {
        throw new Error('Level not found');
    }

    return level;
}

module.exports = {
    getAllLevels,
    getLevelById
};