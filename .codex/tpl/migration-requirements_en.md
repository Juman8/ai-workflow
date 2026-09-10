# Migration Requirements Definition

| Item | Details |
|------|---------|
| Project Name | |
| Created | |
| Author | |
| Source System | |
| Target System | |

> **This document is used for projects that involve migration or cutover from an existing system.**

---

## 1. Migration Overview

| Item | Details |
|------|---------|
| Background & Purpose of Migration | |
| Migration Method | Big-bang / Phased / Parallel operation |
| Planned Migration Date | |
| Migration Lead | |

---

## 2. Migration Scope

### 2.1 Data Migration

| No | Data Type | Source | Destination | Migration Method | Approx. Count | Notes |
|----|-----------|--------|-------------|-----------------|---------------|-------|
| 1 | Master data | | | SQL import / CSV | | |
| 2 | Transaction data | | | | | |
| 3 | Files & attachments | | | | | |

### 2.2 Out of Scope

| No | Data Type | Reason |
|----|-----------|--------|
| 1 | | |

---

## 3. Migration Procedure

### 3.1 Pre-Migration Preparation

- [ ] Extract and cleanse data from the source system
- [ ] Create migration tools and scripts
- [ ] Build and verify the target environment
- [ ] Conduct a migration rehearsal

### 3.2 Migration Steps

| Step | Task | Assignee | Duration | Verification Items |
|------|------|----------|----------|-------------------|
| 1 | Shut down source system (if required) | | | |
| 2 | Export data | | | |
| 3 | Transform and cleanse data | | | |
| 4 | Import data | | | |
| 5 | Verify data integrity | | | |
| 6 | Confirm new system operation | | | |
| 7 | Declare migration complete | | | |

### 3.3 Rollback Procedure

<!-- Steps to revert if the migration fails -->

| Step | Task | Decision Criteria |
|------|------|------------------|
| 1 | Shut down new system | |
| 2 | Restart source system | |
| 3 | Restore data (if required) | |

---

## 4. Data Conversion Specifications

<!-- Fill in when data structures differ between source and destination -->

| Source Field | Source Type | Destination Field | Destination Type | Conversion Rule |
|-------------|-------------|------------------|-----------------|----------------|
| | | | | |

---

## 5. Handover

### 5.1 Business Handover

| Handover Item | Content | From | To | Planned Completion |
|--------------|---------|------|----|--------------------|
| Operating procedures | | | | |
| Administrative tasks | | | | |
| Incident response flow | | | | |

### 5.2 Document Handover

| Document | Storage Location | Handover Status |
|----------|-----------------|----------------|
| User manual | | |
| Administrator manual | | |
| Operations guide | | |
| Incident response guide | | |

### 5.3 Training Plan

| Target Audience | Content | Scheduled Date | Instructor |
|----------------|---------|---------------|------------|
| End users | New system operation training | | |
| Administrators | Admin features & operations training | | |

---

## 6. Verification & Acceptance Criteria

| No | Verification Item | Criteria | Verification Method | Result |
|----|------------------|----------|-------------------|--------|
| 1 | Record count match | Source = Destination | SQL count comparison | |
| 2 | Data content integrity | Sample extraction & visual check | | |
| 3 | Screen display & feature check | All test cases pass | | |
| 4 | Performance check | Response within ○ seconds | | |

---

## Document Revision History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | | | Initial version |
