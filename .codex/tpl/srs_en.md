# Functional & Non-Functional Requirements Document (SRS)

> **Agile Usage:** Finalize "Chapter 2: Non-Functional Requirements" and "Chapter 3: Security Requirements" during Sprint 0. Manage "Chapter 1: Functional Requirements" in the sprint backlog; record only the screen list and key constraints in this document.

| Item | Content |
|------|---------|
| Project Name | |
| Version | |
| Created Date | |
| Author | |

---

## 1. Functional Requirements

### 1.1 Feature List

| No | Feature Name | Description | Priority |
|----|-------------|------------|---------|
| F-01 | | | High/Medium/Low |
| F-02 | | | High/Medium/Low |

### 1.2 Feature Details

#### F-01: Feature Name

- **Overview**:
- **Input**:
- **Processing**:
- **Output**:
- **Error Conditions**:

**Use Case Description**

| Item | Content |
|------|---------|
| Actor | |
| Preconditions | |
| Main Scenario | 1. User performs ○○ action<br>2. System processes ○○<br>3. System displays ○○ |
| Alternative Scenario | (e.g.) 2a. If input is invalid → Show error message and return to Step 2 |
| Postconditions | |

---

### 1.3 Screen List

<!-- For details, refer to screen-design.md -->

| No | Screen ID | Screen Name | Target Users |
|----|-----------|------------|-------------|
| 1 | SCR-001 | | |

### 1.4 Data & Logs

| No | Data Type | Description | Retention Period | Notes |
|----|----------|------------|-----------------|-------|
| 1 | | | | |
| 2 | Logs | Operation logs | ○ years | |

---

## 2. Non-Functional Requirements

### 2.1 Usability & Accessibility

| Item | Requirement |
|------|------------|
| Supported Browsers | Chrome · Edge · Safari (latest version) |
| Supported Devices | PC / Tablet / Smartphone |
| Supported Resolutions | |
| Accessibility Standards | WCAG 2.1 Level AA compliant (if required) |
| Multi-language Support | Japanese only / ○○ languages supported |

### 2.2 Performance Requirements

| Item | Requirement |
|------|------------|
| Response Time | Normal operations: within 3 seconds |
| Concurrent Users | ○○ users |
| Data Retention Period | ○○ years |
| Batch Processing Time | ○ records within ○ minutes |

### 2.3 Scale

| Item | Content |
|------|---------|
| Expected Users | |
| Peak Access Count | |
| Data Volume (Initial) | |
| Data Volume (3 years projected) | |

### 2.4 Reliability

| Item | Requirement |
|------|------------|
| Operating Hours | Weekdays 9:00–18:00 |
| Planned Downtime | Once/month · Late night hours |
| Availability (Uptime) | 99.9% |
| RTO (Recovery Time Objective) | |
| RPO (Recovery Point Objective) | |

### 2.5 Scalability

- 
- 

### 2.6 Backward Compatibility

<!-- Define compatibility with integrated systems and supported versions -->

| Item | Content |
|------|---------|
| Supported OS | |
| Supported Browser Versions | |
| Compatibility with Integrated Systems | |

### 2.7 Business Continuity

| Item | Requirement |
|------|------------|
| Backup Frequency | |
| Backup Retention Period | |
| Failover Method | |

---

## 3. Security Requirements

### 3.1 Information Security

| Item | Requirement |
|------|------------|
| Access Control | Role-Based Access Control (RBAC) |
| Authentication Method | ID/Password / Multi-Factor Authentication (MFA) |
| Data Encryption (at rest) | AES-256, etc. |
| Data Encryption (in transit) | HTTPS (TLS 1.2 or above) |
| Virus Protection | |
| Unauthorized Access Prevention | |
| Security Patch Application | |
| External Media Restrictions | |

### 3.2 Permissions (Role Definitions)

#### Role List

| Role ID | Role Name | Description |
|---------|----------|------------|
| R-01 | General User | |
| R-02 | Admin | |
| R-03 | System Admin | |

#### Feature Access Permission Matrix

<!-- ○: Allowed, ×: Not Allowed, △: Conditionally Allowed -->
<!-- "Feature / Screen" column uses screen IDs from screen-design.md (e.g., SCR-001) -->
<!-- For API endpoints corresponding to each feature, refer to the "Endpoint List" in api-spec.md -->

| Feature / Screen | Screen ID | Main API Endpoint | General User | Admin | System Admin |
|-----------------|:---------:|-------------------|:------------:|:-----:|:------------:|
| (e.g.) Dashboard | SCR-001 | `GET /api/v1/dashboard` | ○ | ○ | ○ |
| (e.g.) Data View | SCR-002 | `GET /api/v1/data` | ○ | ○ | ○ |
| (e.g.) Data Create/Edit | SCR-003 | `POST/PUT /api/v1/data` | × | ○ | ○ |
| (e.g.) Data Delete | SCR-003 | `DELETE /api/v1/data/:id` | × | △ | ○ |
| (e.g.) User Management | SCR-010 | `GET/POST /api/v1/users` | × | × | ○ |
| (e.g.) System Settings | SCR-011 | `PUT /api/v1/settings` | × | × | ○ |

> **△ (Conditional) Details:** Add notes when conditions apply (e.g., only allowed to delete data they created)
>
> **Related Documents:**
> - Screen ID details → `docs/tpl/screen-design.md` (Screen list & Screen ID definitions)
> - API endpoint details → `docs/tpl/api-spec.md` (Endpoint list & authentication requirements)

### 3.3 Operating Environment

| Item | Content |
|------|---------|
| Production Environment | |
| Staging Environment | |
| Development Environment | |
| Supported Browsers | Chrome / Edge / Safari (latest 2 versions) |

---

## 4. External Interface Requirements

| No | Integration Target | Method | Purpose | Notes |
|----|-------------------|--------|---------|-------|
| I-01 | | REST API / CSV | | |

---

## Document History

| Version | Date | Author | Content |
|---------|------|--------|---------|
| 1.0 | | | Initial version |
