// src/modules/program/specialization/specialization.service.js
const prisma = require('../../../config/prisma');

async function getAllSpecializations() {
    return prisma.specialization.findMany({
        select: {
            specialization_id: true,
            name: true
        }
    });
}

async function getSpecializationById(id) {
    const specialization = await prisma.specialization.findUnique({
        where: { specialization_id: id },
        select: {
            specialization_id: true,
            name: true,
            level_specialization: {
                select: {
                    level: {
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
                    }
                }
            }
        }
    });

    if (!specialization) {
        throw new Error('Specialization not found');
    }

    return specialization;
}

module.exports = {
    getAllSpecializations,
    getSpecializationById
};