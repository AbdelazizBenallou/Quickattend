// src/modules/auth/auth.service.js
const prisma = require('../../config/prisma');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'fallback-secret-for-dev-only';
const REFRESH_SECRET = process.env.REFRESH_SECRET || 'dev-refresh-secret';

// Dummy hash for non-existent users (prevents timing/user enumeration attacks)
const DUMMY_HASH = '$argon2id$v=19$m=65536,t=3,p=4$DcYjJbNX7Eq+A/WIO9ZYaQ$3jC76ZFb7t1YHV5gJnoAwmBo0vY4Inui6mZDhQ7gDYw'

async function loginUser(email, password, ip, userAgent = null) {
    // 1. Attempt to find user
    const user = await prisma.users.findUnique({
        where: { email },
        select: {
            user_id: true,
            email: true,
            password_hash: true,
            status: true,
        }
    });


    // 2. Always verify password (even if user doesn't exist)
    const hashToVerify = user ? user.password_hash : DUMMY_HASH;
    const isValid = await argon2.verify(hashToVerify, password);

    // 3. Determine success conditions
    const isAuthenticated = user && isValid && user.status === 'active';
    if (!isAuthenticated) {
        throw new Error('Invalid email or password');
    }
    // 4. If authenticated, fetch roles and permissions
    const userId = user.user_id;
    const userRoles = await prisma.user_role.findMany({
        where: { user_id: userId },
        include: {
            role: {
                include: {
                    role_permission: {
                        include: {
                            permission: true
                        }
                    }
                }
            }
        }
    });

    // Extract roles and permissions from the nested structure
    const roles = userRoles.map(ur => ({
        role_id: ur.role.role_id,
        name: ur.role.name
    }));

    const permissions = [
        ...new Set(
            userRoles.flatMap(ur =>
                ur.role.role_permission.map(rp => ({
                    permission_id: rp.permission.permission_id,
                    name: rp.permission.name
                }))
            )
        )
    ];

    // Generate JWT tokens
    const accessToken = jwt.sign(
        { userId: userId, email: user.email, roles, permissions },
        JWT_SECRET,
        { expiresIn: '5m' }
    );
    
    const refreshToken = jwt.sign(
        { userId: userId, email: user.email },
        REFRESH_SECRET,
        { expiresIn: '10m' }
    );

    // 4b. Log successful login
    await prisma.login_history.create({
        data: {
            user_id: user.user_id,
            ip_address: ip,
            user_agent: userAgent || 'unknown'
        }
    });

    // 4c. Return sanitized user + token
    const safeUser = {
        user_id: userId,
        email: user.email,
        status: user.status
    };
    return { accessToken, refreshToken, user: safeUser };
}


module.exports = { loginUser };