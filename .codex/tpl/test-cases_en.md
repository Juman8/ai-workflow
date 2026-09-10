# Test Specification (Test Cases)

| Item | Content |
|------|---------|
| Project Name | |
| Target Feature | |
| Created Date | |
| Author | |
| Execution Date | |
| Tester | |

---

## Test Case List

### Feature: Login

| No | Test Case | Preconditions | Steps | Expected Result | Result | Bug No |
|----|-----------|--------------|-------|----------------|--------|--------|
| TC-001 | Successful login | A registered user exists | Enter correct email & password and click Login | Navigate to Dashboard | OK / NG | |
| TC-002 | Email not entered | - | Leave email blank and click Login | "Email address is required" is displayed | OK / NG | |
| TC-003 | Incorrect password | A registered user exists | Enter correct email & wrong password and click Login | "Email address or password is incorrect" is displayed | OK / NG | |

---

### Feature: ○○ List / Search

| No | Test Case | Preconditions | Steps | Expected Result | Result | Bug No |
|----|-----------|--------------|-------|----------------|--------|--------|
| TC-010 | List display | Data exists | Open the list screen | Data is displayed at 20 records per page | OK / NG | |
| TC-011 | Name search (results found) | "Yamada" exists | Search for "Yamada" | Results containing "Yamada" are displayed | OK / NG | |
| TC-012 | Name search (no results) | | Search for a name that does not exist | "No matching data found" is displayed | OK / NG | |

---

### Feature: ○○ Registration

| No | Test Case | Preconditions | Steps | Expected Result | Result | Bug No |
|----|-----------|--------------|-------|----------------|--------|--------|
| TC-020 | Successful registration | | Enter all required fields and click Register | Registration completion message is displayed and list is updated | OK / NG | |
| TC-021 | Required field not entered | | Leave required fields blank and click Register | "○○ is required" is displayed for each field | OK / NG | |

---

## Test Result Summary

| Type | Total | PASS | FAIL | Not Run |
|------|-------|------|------|---------|
| Normal cases | | | | |
| Abnormal cases | | | | |
| Total | | | | |
