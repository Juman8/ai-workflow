# Screen Spec: [Screen Name]

## 1. Context & Assets

- **Figma Link:** [Paste specific Figma Frame URL here]
- **Design System / UI Library:** [e.g., Tailwind CSS + Shadcn UI / Material UI]
- **Target Tech Stack:** [e.g., Next.js App Router, TypeScript, Prisma, Node.js]

## 2. Frontend Component Architecture

### UI Layout Hierarchy

- [Parent Layout Component]
  - [Child Component 1]
  - [Child Component 2]

### Component States

- **Initial/Empty State:** [Describe visual behavior]
- **Loading State:** [Describe skeleton or spinner placement]
- **Error State:** [Describe toast alert or inline error banner]

## 3. Interaction & Event Handling

- **[Element Name] (e.g., Submit Button):**
  - **Trigger:** [e.g., On Click]
  - **Action:** [e.g., Validate form, trigger API request, show loading spinner]
  - **Success Outcome:** [e.g., Redirect to `/dashboard`, show success toast]
  - **Failure Outcome:** [e.g., Highlight invalid fields, show error message]

## 4. API Contract (Data Mapping)

### Frontend Request (Client -> API)

- **Method:** [GET / POST / PUT / DELETE]
- **Endpoint:** `[e.g., /api/v1/resource]`
- **Payload Structure (JSON):**

```json
// Paste expected request JSON here
```

### Backend Response (API -> Client)

- **Success Status:** [e.g., 200 OK / 201 Created]
- **Success Payload (JSON):**

```json
// Paste expected success JSON here
```

- **Error Statuses:** [e.g., 400 Bad Request, 401 Unauthorized]

## 5. System Prompt For AI Generation

> **AI Instruction:** Act as a Senior Full-Stack Engineer. Read the Figma frame layout logic via MCP if available. Generate a responsive frontend component using [Tech Stack] that strictly implements the states above. Generate the corresponding backend API route matching the exact JSON structure provided. Ensure absolute alignment between frontend data fetching and backend route handling.
