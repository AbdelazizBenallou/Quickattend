// src/modules/auth/auth.service.js
const prisma = require('../../config/prisma');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');
const { performance } = require('perf_hooks');
const { ACCESS_SECRET, REFRESH_SECRET } = require('../../config/env');


// Dummy hash for non-existent users (prevents timing/user enumeration attacks)
const DUMMY_HASH = '$argon2id$v=19$m=65536,t=3,p=4$DcYjJbNX7Eq+A/WIO9ZYaQ$3jC76ZFb7t1YHV5gJnoAwmBo0vY4Inui6mZDhQ7gDYw'

async function loginUser(email, password, ip, userAgent = null) {

    const t0 = performance.now(); // total timer start

    // 1. Attempt to find user
    const t1 = performance.now();
    const user = await prisma.users.findUnique({
        where: { email },
        include: {
            profile: {
                include: {
                    level: {
                        include: {
                            degree_level: true
                        }
                    },
                    specialization: true
                }
            }
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
    if (!user || !isValid || user.status !== 'active') {
        const tFail = performance.now();
        console.log('Total login time (failed):', (tFail - t0).toFixed(2), 'ms');
        throw new Error('Invalid credentials');
    }

    // 5. fetch profile and specialization and level
    const t5 = performance.now();

    const profile = user.profile;
    const academicInfo = profile
        ? {
            degree: profile.level?.degree_level?.name || null,
            level: profile.level?.name || null,
            specialization: profile.specialization?.name || null
        }
        : null;

    // 4. Fetch roles and permissions

    const userId = user.user_id;
    const userRoles = await prisma.user_role.findMany({
        where: { user_id: userId },
        include: {
            role: true
        }
    });
    const t6 = performance.now();
    console.log('Fetch roles time:', (t6 - t5).toFixed(2), 'ms');

    // Extract roles
    const roles = userRoles.map(r => r.role.name);

    // 5. Generate JWT tokens
    const t7 = performance.now();
    const accessToken = jwt.sign(
        { userId: userId, email: user.email, roles },
        ACCESS_SECRET,
        { expiresIn: '60m' }
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
        status: user.status,
        academic: academicInfo
    };

    return { accessToken, refreshToken, user: safeUser };
}

async function registerUser(first_name, last_name, email, password, ip, userAgent = null) {

    const t0 = performance.now(); // total start

    // -------------------------
    // 1. Transaction block
    // -------------------------
    const newUser = await prisma.$transaction(async (tx) => {

        // 🔹 Hash password
        const tHashStart = performance.now();
        const password_hash = await argon2.hash(password, {
            type: argon2.argon2id,
            memoryCost: 65536,
            timeCost: 3,
            parallelism: 4
        });
        const tHashEnd = performance.now();
        console.log('Hash time:', (tHashEnd - tHashStart).toFixed(2), 'ms');


        // 🔹 Create user
        const tCreateStart = performance.now();
        let createdUser;
        try {
            createdUser = await tx.users.create({
                data: {

                    email,
                    password_hash,
                    status: 'active'
                }
            });
        } catch (err) {
            if (err.code === 'P2002') {
                throw new Error('Email already exists');
            }
            throw err;
        }
        const tCreateEnd = performance.now();
        console.log('User insert time:', (tCreateEnd - tCreateStart).toFixed(2), 'ms');


        // 🔹 Get default role
        const tRoleStart = performance.now();
        const defaultRole = await tx.role.findUnique({
            where: { name: 'Student' }
        });

        if (!defaultRole) {
            throw new Error('Default role not configured');
        }
        const tRoleEnd = performance.now();
        console.log('Get role time:', (tRoleEnd - tRoleStart).toFixed(2), 'ms');


        // 🔹 Insert user_role
        const tUserRoleStart = performance.now();
        await tx.user_role.create({
            data: {
                user_id: createdUser.user_id,
                role_id: defaultRole.role_id
            }
        });
        const tUserRoleEnd = performance.now();
        console.log('User_role insert time:', (tUserRoleEnd - tUserRoleStart).toFixed(2), 'ms');

        // 🔹 Create profile
        const tProfileStart = performance.now();
        await tx.profile.create({
            data: {
                user_id: createdUser.user_id,
                first_name,
                last_name
            }
        });

        const tProfileEnd = performance.now();
        console.log('Profile insert time:', (tProfileEnd - tProfileStart).toFixed(2), 'ms');

        return createdUser;
    });

    const tAfterTransaction = performance.now();
    console.log('Transaction total time:', (tAfterTransaction - t0).toFixed(2), 'ms');


    // -------------------------
    // 2. Load roles & permissions
    // -------------------------
    const tRolesFetchStart = performance.now();
    const userId = newUser.user_id;
    const userRoles = await prisma.user_role.findMany({
        where: { user_id: userId },
        include: {
            role: true
        }
    });

    const tRolesFetchEnd = performance.now();
    console.log('Fetch roles & permissions time:',
        (tRolesFetchEnd - tRolesFetchStart).toFixed(2), 'ms');


    const roles = userRoles.map(r => r.role.name);

    // -------------------------
    // 3. Generate JWT
    // -------------------------
    const tJwtStart = performance.now();
    const accessToken = jwt.sign(
        { userId: newUser.user_id, email: newUser.email, roles },
        ACCESS_SECRET,
        { expiresIn: '5m' }
    );

    const refreshToken = jwt.sign(
        { userId: newUser.user_id, email: newUser.email },
        REFRESH_SECRET,
        { expiresIn: '10m' }
    );
    const tJwtEnd = performance.now();
    console.log('JWT generation time:', (tJwtEnd - tJwtStart).toFixed(2), 'ms');


    // -------------------------
    // 4. Insert login history
    // -------------------------
    const tLoginHistoryStart = performance.now();
    await prisma.login_history.create({
        data: {
            user_id: newUser.user_id,
            ip_address: ip,
            user_agent: userAgent || 'unknown'
        }
    });
    const tLoginHistoryEnd = performance.now();
    console.log('Login history insert time:',
        (tLoginHistoryEnd - tLoginHistoryStart).toFixed(2), 'ms');


    // -------------------------
    // TOTAL TIME
    // -------------------------
    const tFinal = performance.now();
    console.log('Total register time:',
        (tFinal - t0).toFixed(2), 'ms');


    return {
        accessToken,
        refreshToken,
        user: {
            user_id: newUser.user_id,
            email: newUser.email,
            status: newUser.status,
            first_name: first_name,
            last_name: last_name
        }
    };
}

async function refreshAccessToken(userId) {

    // 1️⃣ Check user exists
    const user = await prisma.users.findUnique({
        where: { user_id: userId }
    });

    if (!user) {
        throw { status: 401, message: 'User does not exist' };
    }

    // 2️⃣ Check activation
    if (user.status !== 'active') {
        throw { status: 403, message: 'Account is not active' };
    }

    // 3️⃣ Get roles & permissions
    const userRoles = await prisma.user_role.findMany({
        where: { user_id: userId },
        include: {
            role: true
        }
    });

    const roles = userRoles.map(r => r.role.name);

    // 4️⃣ Generate new access token
    const accessToken = jwt.sign(
        { userId, email: user.email, roles },
        ACCESS_SECRET,
        { expiresIn: '5m' }
    );

    return accessToken;
}

module.exports = { loginUser, registerUser, refreshAccessToken };