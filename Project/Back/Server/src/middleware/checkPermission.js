// src/middleware/checkPermission.js

const prisma = require('../config/prisma');
const jwt = require('jsonwebtoken');
const { ACCESS_SECRET } = require('../config/env');

function checkPermission(permissionName) {
  return async (req, res, next) => {
    try {

      const token =
        req.cookies?.accessToken ||
        req.headers.authorization?.split(" ")[1];

      if (!token) {
        return res.status(401).json({ message: "Unauthorized" });
      }

      const decoded = jwt.verify(token, ACCESS_SECRET);
      const userId = decoded.userId;

      const permissions = await prisma.permission.findMany({
        where: {
          role_permission: {
            some: {
              role: {
                user_role: {
                  some: {
                    user_id: userId
                  }
                }
              }
            }
          },
          name: permissionName
          
        }
      });
      console.log(permissions);
      
      if (!permissions.length) {
        return res.status(403).json({ message: "Forbidden" });
      }

      req.user = decoded;

      next();

    } catch (err) {
      return res.status(401).json({ message: "Invalid token" });
    }
  };
}

module.exports = checkPermission;