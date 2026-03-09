const redis = require('../config/redis');
const getUserPermissions = require('../utils/getUserPermissions');
const response = require('../utils/response');

function checkPermission(permissionName) {
  return async (req, res, next) => {
    try {

      const userId = req.user.userId;
      const cacheKey = `permissions:user:${userId}`;
      let permissions = await redis.get(cacheKey);
      if (!permissions) {
        // load from database
        const dbPermissions = await getUserPermissions(userId);
        permissions = dbPermissions;
        await redis.set(
          cacheKey,
          JSON.stringify(dbPermissions),
          { EX: 600 }
        );

      } else {
        permissions = JSON.parse(permissions);
      }

      if (!permissions.includes(permissionName)) {
        return response.error(res, "Forbidden", 403);
      }
      next();

    } catch (err) {
      return response.error(res, "Permission check failed", 500);
    }
  };

}

module.exports = checkPermission;