# AI Coding Standards

| Item | Content |
|------|---------|
| Project Name | |
| Version | |
| Created Date | |
| Author | |

> This file defines the coding rules that AI must follow. Use it together with CLAUDE.md.

---

## 1. Common (All Languages / Frameworks)

### 1-1. Basic Policy

- Prioritize code readability (optimize for performance only when necessary)
- A function should do only one thing (Single Responsibility Principle)
- Keep functions within 50 lines
- Keep files within 800 lines
- Define magic numbers as constants
- Prohibit use of the `any` type (for TypeScript)

### 1-2. Naming Conventions

| Target | Convention | Example |
|--------|-----------|---------|
| Variables | camelCase | `userName`, `totalPrice` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| Functions | camelCase (verb prefix) | `getUser()`, `createOrder()` |
| Classes | PascalCase | `UserService`, `OrderRepository` |
| Files | kebab-case | `user-service.ts`, `order-repository.ts` |
| Components | PascalCase | `UserList.tsx`, `OrderForm.tsx` |

### 1-3. API Endpoint Naming Conventions

- Use **plural nouns** for resource names (verbs are prohibited)
- Use the format `/<resource>/<id>/<sub-resource>` for hierarchy
- Always include the version prefix `/api/v1/`

| Operation | Method | Path Example | Prohibited Pattern |
|-----------|--------|-------------|-------------------|
| List | GET | `/api/v1/users` | `/api/v1/getUsers` ❌ |
| Get one | GET | `/api/v1/users/:id` | `/api/v1/user/:id` ❌ |
| Create | POST | `/api/v1/users` | `/api/v1/createUser` ❌ |
| Update | PUT/PATCH | `/api/v1/users/:id` | `/api/v1/updateUser` ❌ |
| Delete | DELETE | `/api/v1/users/:id` | `/api/v1/deleteUser` ❌ |
| Sub-resource | GET | `/api/v1/users/:id/orders` | `/api/v1/getUserOrders` ❌ |

### 1-4. Comments

- Write comments explaining *why*, not *what*
- Keep comments consistently in English or Japanese
- Do not comment self-evident code

```typescript
// Bad: comment describing what the code does
// Get the user
const user = await getUser(userId);

// Good: comment explaining why
// Return from cache without hitting the DB if a cache entry exists
const user = cache.get(userId) ?? await getUser(userId);
```

---

## 2. TypeScript / JavaScript

### 2-1. Type Definitions

```typescript
// Bad
const user: any = fetchUser();

// Good
interface User {
  id: string;
  name: string;
  email: string;
}
const user: User = await fetchUser();
```

### 2-2. Async Processing

```typescript
// Bad: callback hell
fetchUser(id, (user) => {
  fetchOrders(user.id, (orders) => { ... });
});

// Good: async/await
const user = await fetchUser(id);
const orders = await fetchOrders(user.id);
```

### 2-3. Error Handling

```typescript
// Bad: silently ignoring errors
try {
  await saveUser(user);
} catch (_) {}

// Good: log the error and notify the user
try {
  await saveUser(user);
} catch (error) {
  logger.error('Failed to save user', { userId: user.id, error });
  throw new AppError('Save failed. Please try again.');
}
```

### 2-4. Immutable Patterns

```typescript
// Bad: mutating the existing object directly
user.name = 'New Name';

// Good: return a new object
const updatedUser = { ...user, name: 'New Name' };
```

---

## 3. React / Frontend

### 3-1. Component Design

- Separate presentation (Presentational) from logic (Container)
- Keep Props to the minimum necessary
- Do not omit the `useEffect` dependency array

```tsx
// Bad: logic and presentation mixed together
function UserList() {
  const [users, setUsers] = useState([]);
  useEffect(() => { fetch('/api/users').then(...) }, []);
  return <ul>{users.map(u => <li>{u.name}</li>)}</ul>;
}

// Good: extract logic into a custom hook
function useUsers() {
  const [users, setUsers] = useState<User[]>([]);
  useEffect(() => { fetchUsers().then(setUsers) }, []);
  return users;
}

function UserList() {
  const users = useUsers();
  return <ul>{users.map(u => <li key={u.id}>{u.name}</li>)}</ul>;
}
```

### 3-2. Prohibited Items

- Do not use `dangerouslySetInnerHTML` (XSS risk)
- Do not overuse inline styles (use design tokens instead)
- Do not define multiple components in one file (only one exported component per file)

---

## 4. Backend (Node.js / Express)

### 4-1. API Router

```typescript
// Bad: writing business logic directly in the router
router.get('/users', async (req, res) => {
  const users = await db.query('SELECT * FROM users');
  res.json(users);
});

// Good: separate business logic into a service layer
router.get('/users', authenticate, async (req, res) => {
  const users = await userService.findAll();
  res.json({ data: users });
});
```

### 4-2. Validation

```typescript
// Bad: no validation
router.post('/users', async (req, res) => {
  await createUser(req.body);
});

// Good: validate with Zod
const createUserSchema = z.object({
  name: z.string().min(1).max(50),
  email: z.string().email(),
});

router.post('/users', async (req, res) => {
  const data = createUserSchema.parse(req.body);
  await createUser(data);
});
```

---

## 5. Database

### 5-1. Queries

```typescript
// Bad: risk of SQL injection
const users = await db.query(`SELECT * FROM users WHERE name = '${name}'`);

// Good: parameterized query
const users = await db.query('SELECT * FROM users WHERE name = $1', [name]);
```

### 5-2. Transactions

- Always wrap multiple DB operations in a transaction
- Roll back on failure

---

## 6. Security

- Do not include hardcoded credentials or API keys
- Always validate user input
- Add authentication middleware to endpoints that require authentication
- Do not leave `console.log` in production code (use `logger` instead)
- Do not include sensitive information in responses (e.g., password hashes)

---

## 7. Linter / Formatter

> The lint and format settings for this project are managed in the files below.
> AI-generated code **must also conform to these settings**.

| Tool | Config File | When Applied |
|------|------------|-------------|
| ESLint | `.eslintrc.js` / `.eslintrc.json` | Before commit · Automated check in CI |
| Prettier | `.prettierrc` / `prettier.config.js` | On file save · Before commit |
| Stylelint | `.stylelintrc` | When editing CSS files |

**Instructions for AI:** After generating code, run the following to verify formatting.

```bash
npm run lint       # ESLint check
npm run format     # Prettier auto-fix
```

Do not modify or overwrite existing settings. Adding new rules requires review first.

---

## 8. Testing

- Write tests first for new features (TDD)
- Maintain 80%+ code coverage
- Place test files in the same directory as the target file (`*.test.ts`)
- Minimize mocking (use a real DB for integration tests)
