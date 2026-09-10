# Environment Setup Guide

| Item | Details |
|------|---------|
| Project Name | |
| Target Environment | Local development environment |
| Created | |
| Author | |

---

## Prerequisites

| Software | Version | Verification Command |
|----------|---------|---------------------|
| Node.js | 20.x or later | `node -v` |
| npm / pnpm | Latest | `npm -v` |
| Git | Latest | `git --version` |
| Docker | Latest | `docker -v` |
| PostgreSQL | 15.x or later | `psql --version` |

---

## 1. Clone the Repository

```bash
git clone https://github.com/your-org/project-name.git
cd project-name
```

---

## 2. Install Dependencies

```bash
npm install
# or
pnpm install
```

---

## 3. Configure Environment Variables

Copy `.env.example` to create `.env`.

```bash
cp .env.example .env
```

Edit `.env` and set each value.

```env
# Application
APP_PORT=3000
APP_ENV=development

# Database
DATABASE_URL=postgresql://postgres:password@localhost:5432/dbname

# Authentication
JWT_SECRET=your-secret-key-here
JWT_EXPIRES_IN=7d

# External services (if required)
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
```

> **Note:** The `.env` file is excluded from Git. Do not share it externally, as it contains sensitive information.

---

## 4. Database Setup

### 4-1. Create the Database

```bash
# Connect to PostgreSQL and create the database
psql -U postgres -c "CREATE DATABASE dbname;"
```

### 4-2. Run Migrations

```bash
npm run db:migrate
# or
npx prisma migrate dev
```

### 4-3. Seed Initial Data

```bash
npm run db:seed
```

---

## 5. Start the Development Server

```bash
npm run dev
```

Open `http://localhost:3000` in your browser and confirm the application is displayed.

---

## 6. Run Tests

```bash
# Run all tests
npm test

# Unit tests only
npm run test:unit

# E2E tests
npm run test:e2e
```

---

## 7. Build

```bash
npm run build
```

---

## 8. Start with Docker (Optional)

```bash
# Start containers
docker compose up -d

# View logs
docker compose logs -f

# Stop containers
docker compose down
```

---

## 9. Troubleshooting

### Port Already in Use

```bash
# Check which process is using the port (macOS / Linux)
lsof -i :3000

# Kill the process
kill -9 <PID>
```

### Cannot Connect to Database

- Verify the `DATABASE_URL` setting is correct.
- Check that PostgreSQL is running:
  ```bash
  pg_isready
  ```

### npm install Fails

```bash
# Clear cache and retry
npm cache clean --force
npm install
```

---

## 10. References

| Resource | URL |
|----------|-----|
| Project README | README.md |
| API Specification | tpl/api-spec_en.md |
| DB Design Document | tpl/db-design_en.md |
