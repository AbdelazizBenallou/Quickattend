-- =========================
-- Permission & Roles
-- =========================

CREATE TABLE permission (
    permission_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE role (
    role_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE role_permission (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permission(permission_id) ON DELETE CASCADE
);

-- =========================
-- Users
-- =========================

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE user_role (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE
);

-- =========================
-- Degree / Level / Specialization
-- =========================

CREATE TABLE degree_level (
    degree_level_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE level (
    level_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    degree_level_id INT NOT NULL,
    FOREIGN KEY (degree_level_id)
        REFERENCES degree_level(degree_level_id)
        ON DELETE CASCADE
);

CREATE TABLE specialization (
    specialization_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE level_specialization (
    level_id INT NOT NULL,
    specialization_id INT NOT NULL,
    PRIMARY KEY (level_id, specialization_id),
    FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specialization(specialization_id) ON DELETE CASCADE
);

-- =========================
-- Profile
-- =========================

CREATE TABLE profile (
    user_id INT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    date_birth DATE,
    address TEXT,
    level_id INT,
    specialization_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES level(level_id),
    FOREIGN KEY (specialization_id) REFERENCES specialization(specialization_id)
);

-- =========================
-- Workshop / Classes
-- =========================

CREATE TABLE workshop (
    workshop_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    leader_user_id INT,
    FOREIGN KEY (leader_user_id) REFERENCES users(user_id)
);

CREATE TABLE class (
    class_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    date DATE,
    created_at TIMESTAMP DEFAULT NOW(),
    workshop_id INT NOT NULL,
    FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id) ON DELETE CASCADE
);

CREATE TABLE properties (
    class_id INT PRIMARY KEY,
    room_number TEXT,
    capacity INT,
    equipment TEXT,
    FOREIGN KEY (class_id) REFERENCES class(class_id) ON DELETE CASCADE
);

CREATE TABLE user_workshop (
    user_id INT NOT NULL,
    workshop_id INT NOT NULL,
    PRIMARY KEY (user_id, workshop_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id) ON DELETE CASCADE
);

CREATE TABLE user_class (
    user_class_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES class(class_id) ON DELETE CASCADE
);

-- =========================
-- Auth Tracking
-- =========================

CREATE TABLE login_history (
    login_history_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    login_at TIMESTAMP DEFAULT NOW(),
    logout_at TIMESTAMP,
    ip_address TEXT,
    user_agent TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE refresh_tokens (
    refresh_token_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    token TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    revoked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- =========================
-- Indexes (performance)
-- =========================

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_login_history_user ON login_history(user_id);
CREATE INDEX idx_refresh_tokens_user ON refresh_tokens(user_id);
CREATE INDEX idx_class_workshop ON class(workshop_id);

