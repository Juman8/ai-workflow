# Test Plan

| Item | Content |
|------|---------|
| Project Name | |
| Version | |
| Created Date | |
| Author | |

---

## 1. Test Policy

<!-- Describe the purpose of testing and quality standards -->

- Unit test coverage: 80% or above
- Critical features (authentication, payment, data storage) must always have E2E tests

## 2. Test Scope

### In Scope

| No | Test Target | Test Type |
|----|------------|-----------|
| 1 | Authentication feature | Unit · Integration · E2E |
| 2 | ○○ List Screen | Unit · E2E |
| 3 | ○○ Registration feature | Unit · Integration |

### Out of Scope

- 

## 3. Test Types

| Type | Tool | Owner | Timing |
|------|------|-------|--------|
| Unit Test | Jest | Developer | During implementation |
| Integration Test | Jest + Supertest | Developer | After implementation |
| E2E Test | Playwright | QA | Before release |
| User Acceptance Test (UAT) | Manual | Customer | Before release |

## 4. AI-Generated Code Specific Testing Perspectives

> AI-generated code may carry different risks compared to human-written code. The following perspectives must always be verified.

| Perspective | Check Content | Corresponding Test Type |
|-------------|--------------|------------------------|
| Boundary values & edge cases | Are empty strings, null, max/min values covered — areas AI tends to overlook? | Unit test |
| Input validation | Is user input properly sanitized and validated (SQLi, XSS)? | Unit test · Security test |
| Error handling | Are unexpected API responses and DB exceptions handled appropriately? | Integration test |
| Type safety | Does TypeScript type checking pass? Are there any `any` types mixed in? | Build · Static analysis |
| Hardcoding | Are environment-specific values (URLs, IDs) hardcoded? | Code review |
| Consistency with existing code | Are existing components and hooks reused correctly (no duplicate custom implementations)? | Code review · Integration test |
| Performance | Are there N+1 queries or unnecessary re-renders? | Integration test · Load test |
| Security | Are there authentication/authorization bypasses (cases where AI omits implementation)? | Security test |

## 5. Test Data Policy

| Item | Policy |
|------|--------|
| Personal information | Do not use real data. Use dummy data (faker.js, etc.) |
| Boundary value data | Always prepare data for max length, min value, 0 records, and upper limit counts |
| Anomalous data | Validate with data containing SQL injection strings and script tags |
| Production data usage | Prohibited (production data without masking/anonymization must not be brought into the test environment) |

## 6. Test Schedule

| Phase | Start Date | End Date | Owner |
|-------|-----------|----------|-------|
| Unit Test | | | |
| Integration Test | | | |
| E2E Test | | | |
| UAT | | | |

## 7. Pass/Fail Criteria

| Item | Pass Criteria |
|------|--------------|
| Unit test coverage | 80% or above |
| E2E tests | All cases PASS |
| Critical bugs (P1) | 0 |
| High bugs (P2) | 0 (or agreed response plan) |

## 8. Bug Priority Definitions

| Priority | Definition | Response Deadline |
|----------|-----------|-------------------|
| P1 (Critical) | System outage · Data loss · Security vulnerability | Same day |
| P2 (High) | Core features unavailable | Next business day |
| P3 (Medium) | Part of a feature unavailable · Workaround exists | Within current sprint |
| P4 (Low) | Minor display issue · Typo | Next sprint or later |
