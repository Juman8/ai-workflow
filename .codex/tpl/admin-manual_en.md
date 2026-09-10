# Admin Manual

| Item | Content |
|------|---------|
| System Name | |
| Version | |
| Created Date | |
| Author | |
| Revision History | v1.0 Initial version |

---

## Introduction

This manual describes the operation and management tasks to be performed by the administrators of the XX System.

### Target Audience

- System Administrators
- IT Personnel

### Prerequisites

- An administrator account has been issued.
- SSH access to the server is available (if required).

---

## 1. Administrator Login

1. Open the administrator URL in your browser.  
   `https://XX.example.com/admin`
2. Log in with your administrator account.

---

## 2. User Management

### 2-1. Creating a New User

1. Click "User Management" on the admin dashboard.
2. Click the "Add User" button.
3. Enter the following information:

| Item | Required | Description |
|------|----------|-------------|
| Name | ✓ | |
| Email Address | ✓ | Used as login ID |
| Role | ✓ | General User / Administrator |
| Initial Password | ✓ | Must be notified to the user separately |

4. Click the "Register" button.
5. Notify the user of their initial password (email recommended).

### 2-2. Disabling a User

1. Select the target user from the user list.
2. Click the "Disable" button.
3. The target user will no longer be able to log in.

> Please promptly disable users who have resigned or transferred.

### 2-3. Password Reset

1. Select the target user from the user list.
2. Click the "Password Reset" button.
3. A new initial password will be generated.
4. Notify the user.

---

## 3. Master Data Management

### 3-1. Updating XX Master

1. Click "Master Management" -> "XX Master" on the admin dashboard.
2. Perform add, edit, or delete operations.

> **Caution:** Deleting master data may affect existing data. Check the impact scope before deleting.

---

## 4. Logs & Audit

### 4-1. Checking Operation Logs

1. Click "Log Management" on the admin dashboard.
2. Filter by period or user.
3. Exportable in CSV format.

### 4-2. Checking Login History

1. Click "Login History" on the admin dashboard.
2. Periodically check for any suspicious access.

---

## 5. Backup & Restore

### 5-1. Backup

| Type | Frequency | Retention Period | Location |
|------|-----------|------------------|----------|
| Database | Daily 02:00 | 30 days | S3 Bucket |
| File Storage | Weekly | 12 weeks | S3 Bucket |

Backups are executed automatically, but please verify every Monday that they have completed successfully.

### 5-2. Restore Procedure

```bash
# DB Restore (Example)
pg_restore -U postgres -d dbname /path/to/backup.dump
```

> Always verify the restore procedure in a verification environment before executing it in the production environment.

---

## 6. Periodic Maintenance

| Task | Frequency | Owner |
|------|-----------|-------|
| Verify backup status | Every Monday | Administrator |
| Check log capacity | Monthly | Administrator |
| Check SSL certificate expiry | Monthly | Administrator |
| Apply security patches | As needed (Same day for emergencies) | Infrastructure Lead |

---

## 7. Incident Response

### 7-1. Application Failure

1. Check the error log.  
   `/var/log/app/error.log`
2. Restart the application if necessary.  
   ```bash
   systemctl restart app-name
   ```
3. If it doesn't improve, contact the development vendor.

### 7-2. Contact Information

| Category | Contact |
|----------|---------|
| Development Vendor (Emergency) | XX Co., Ltd. Contact: XX (TEL: 000-000-0000) |
| Infrastructure | Cloud Team (infra@example.com) |
