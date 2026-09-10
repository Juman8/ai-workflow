# Business Flow Diagram

| Item | Content |
|------|---------|
| Project Name | |
| Target Process | |
| Created Date | |
| Author | |

---

## As-Is (Current Business Flow)

```mermaid
flowchart TD
    A([Start]) --> B[Step 1]
    B --> C{Decision}
    C -->|Yes| D[Step 2a]
    C -->|No| E[Step 2b]
    D --> F([End])
    E --> F
```

### Current Issues

| No | Issue | Impact |
|----|-------|--------|
| 1 | | |
| 2 | | |

---

## To-Be (Future Business Flow)

```mermaid
flowchart TD
    A([Start]) --> B[Step 1]
    B --> C{Decision}
    C -->|Yes| D[Step 2a]
    C -->|No| E[Step 2b]
    D --> F([End])
    E --> F
```

### Improvement Points

| No | Improvement | Expected Effect |
|----|------------|----------------|
| 1 | | |
| 2 | | |

---

## Actors

| Actor | Role |
|-------|------|
| | |

---

## Use Case Diagram

<!-- Illustrate the relationship between actors and system features. For detailed feature list, see SRS 1.1; for use case descriptions, see SRS 1.2 -->

```mermaid
graph LR
    subgraph System
        UC1[Use Case 1]
        UC2[Use Case 2]
        UC3[Use Case 3]
    end
    A1((General User)) --> UC1
    A1 --> UC2
    A2((Admin)) --> UC2
    A2 --> UC3
```

| Use Case | Description | Target Actor |
|---------|------------|-------------|
| Use Case 1 | | General User |
| Use Case 2 | | General User · Admin |
| Use Case 3 | | Admin |
