// src/modules/auth/auth.service.js
const prisma = require('../../config/prisma');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');
const { performance } = require('perf_hooks');

const JWT_SECRET = process.env.JWT_SECRET || 'fallback-secret-for-dev-only';
const REFRESH_SECRET = process.env.REFRESH_SECRET || 'dev-refresh-secret';

// Dummy hash for non-existent users (prevents timing/user enumeration attacks)
const DUMMY_HASH = '$argon2id$v=19$m=65536,t=3,p=4$DcYjJbNX7Eq+A/WIO9ZYaQ$3jC76ZFb7t1YHV5gJnoAwmBo0vY4Inui6mZDhQ7gDYw'

async function loginUser(email, password, ip, userAgent = null) {

    const t0 = performance.now(); // total timer start

    // 1. Attempt to find user
    const t1 = performance.now();
    const user = await prisma.users.findUnique({
        where: { email },
        select: {
            user_id: true,
            email: true,
            password_hash: true,
            status: true,
        }
    });
    const t2 = performance.now();
    console.log('Find user time:', (t2 - t1).toFixed(2), 'ms');


    // 2. Always verify password (even if user doesn't exist)
    const t3 = performance.now();
    const hashToVerify = user ? user.password_hash : DUMMY_HASH;
    const isValid = await argon2.verify(hashToVerify, password);
    const t4 = performance.now();
    console.log('Password verify time:', (t4 - t3).toFixed(2), 'ms');


    // 3. Determine success conditions
    const isAuthenticated = user && isValid && user.status === 'active';
    if (!isAuthenticated) {
        const tFail = performance.now();
        console.log('Total login time (failed):', (tFail - t0).toFixed(2), 'ms');
        throw new Error('Invalid email or password');
    }

    // 4. Fetch roles and permissions
    const t5 = performance.now();
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
    const t6 = performance.now();
    console.log('Fetch roles & permissions time:', (t6 - t5).toFixed(2), 'ms');

    // Extract roles
    const roles = userRoles.map(ur => ({
        role_id: ur.role.role_id,
        name: ur.role.name
    }));

    // Extract permissions (unique)
    const permissions = [
        ...new Map(
            userRoles.flatMap(ur =>
                ur.role.role_permission.map(rp => [
                    rp.permission.permission_id,
                    {
                        permission_id: rp.permission.permission_id,
                        name: rp.permission.name
                    }
                ])
            )
        ).values()
    ];

    // 5. Generate JWT tokens
    const t7 = performance.now();
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
    const t8 = performance.now();
    console.log('JWT generation time:', (t8 - t7).toFixed(2), 'ms');


    // 6. Log successful login
    const t9 = performance.now();
    await prisma.login_history.create({
        data: {
            user_id: user.user_id,
            ip_address: ip,
            user_agent: userAgent || 'unknown'
        }
    });
    const t10 = performance.now();
    console.log('Login history insert time:', (t10 - t9).toFixed(2), 'ms');


    // Total time
    const tFinal = performance.now();
    console.log('Total login time (success):', (tFinal - t0).toFixed(2), 'ms');


    // Return sanitized user + tokens
    const safeUser = {
        user_id: userId,
        email: user.email,
        status: user.status
    };

    return { accessToken, refreshToken, user: safeUser };
}

module.exports = { loginUser };