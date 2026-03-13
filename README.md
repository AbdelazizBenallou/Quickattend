# Backend System – Node.js, Prisma, PostgreSQL

A scalable backend API built with **Node.js**, **Express**, **PostgreSQL**, and **Prisma ORM**.
The system includes **JWT authentication**, **role-based access control (RBAC)**, **Redis caching**, and an automated **database backup strategy**.

---

# Features

* User Authentication (JWT Access + Refresh Tokens)
* Role Based Access Control (RBAC)
* Redis Permission Caching
* Prisma ORM with PostgreSQL
* Secure Middleware Architecture
* API Documentation with Swagger
* PostgreSQL Automated Backup System
* Grandfather–Father–Son Backup Strategy

---

# Project Structure

```
Project
│
├── Back
│   ├── DB
│   │   ├── backup_fin.sh        # Automated backup script
│   │   └── Doc_Exp              # Backup documentation
│   │
│   └── Server
│       ├── prisma
│       │   └── schema.prisma    # Database schema
│       │
│       ├── src
│       │   ├── config           # Environment, Prisma, Redis, Swagger
│       │   ├── middleware       # Auth, validation, permissions
│       │   ├── modules
│       │   │   ├── auth         # Authentication module
│       │   │   ├── users        # User management
│       │   │   ├── workshop     # Workshop management
│       │   │   └── rbac         # Roles & permissions
│       │   │
│       │   └── utils            # Helper utilities
│       │
│       ├── package.json
│       └── server.js
│
└── Front
    └── Mobile_App
```

---

# Technologies Used

* Node.js
* Express.js
* PostgreSQL
* Prisma ORM
* Redis
* JWT Authentication
* Swagger API Docs
* Docker
* Bash (Backup Scripts)

---

# Prerequisites

Before running the project install:

* Node.js (v18+ recommended)
* PostgreSQL
* Redis
* Docker (for database container)
* npm

---

# Environment Variables

Create a `.env` file inside:

```
Back/Server/
```

Example:

```
DATABASE_URL="postgresql://user:password@localhost:5432/dbname"

ACCESS_SECRET="your_access_secret"
REFRESH_SECRET="your_refresh_secret"

PORT=5434
NODE_ENV=dev
```

---

# Installation

Clone the repository:

```
git clone https://github.com/yourusername/project.git
cd project/Back/Server
```

Install dependencies:

```
npm install
```

---

# Database Setup

Generate Prisma client:

```
npx prisma generate
```

Run migrations:

```
npx prisma migrate dev
```

Optional: open Prisma Studio

```
npx prisma studio
```

---

# Run the Server

Start the backend server:

```
npm start
```

or

```
node server.js
```

The API will run on:

```
http://localhost:5434
```

---

# API Documentation

Swagger documentation is available at:

```
http://localhost:5434/api-docs
```

---

# Authentication System

The system uses:

* **Access Token** (short-lived)
* **Refresh Token** (used to generate new access tokens)

Login flow:

1. User logs in
2. Server returns access + refresh tokens
3. Access token used for API requests
4. Refresh token generates new access token when expired

---

# Role Based Access Control (RBAC)

Permissions are assigned to roles and cached using Redis.

Flow:

```
User → Role → Permissions
```

Middleware checks permission before accessing protected routes.

Example:

```
checkPermission("CREATE_WORKSHOP")
```

---

# Redis Permission Caching

To reduce database load, user permissions are cached in Redis.

Cache key format:

```
permissions:user:{userId}
```

Cache TTL:

```
10 minutes
```

---

# PostgreSQL Backup System

The project includes an automated **database backup system**.

Backup script:

```
Back/DB/backup_fin.sh
```

Backup types:

* Daily backups
* Weekly backups
* Monthly backups

Strategy used:

```
Grandfather – Father – Son
```

Retention policy:

```
7 daily backups
4 weekly backups
12 monthly backups
```

Run manually:

```
./backup_fin.sh
```

Schedule automatic backups using cron:

```
crontab -e
```

Example (every day at 2 AM):

```
0 2 * * * /full/path/to/backup_fin.sh
```

---

# Security Features

* JWT token authentication
* HTTP-only cookies
* Permission middleware
* Origin checking
* Rate limiting
* Error handling middleware

---

# Future Improvements

* Docker Compose setup
* CI/CD pipeline
* Automated testing
* Logging system
* Monitoring

---

# License

MIT License

---

# Author

Aziz-BlaCk14


