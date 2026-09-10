# Screen Spec: User Profile Settings

## 1. Context & Assets

- **Figma Link:** https://figma.com
- **Design System / UI Library:** Tailwind CSS + Shadcn UI Components
- **Target Tech Stack:** React (Next.js 14), TypeScript, Node.js (Express), Zod Validation

## 2. Frontend Component Architecture

### UI Layout Hierarchy

- `SettingsLayout` (Sidebar navigation + Main content area)
  - `ProfileForm` (Card wrapper)
    - `AvatarUpload` (Circular image placeholder with "Change" hover overlay)
    - `InputField` (Name - Text string)
    - `InputField` (Email - Disabled text string)
    - `Button` (Submit - Primary variant)

### Component States

- **Initial State:** Form fields populated with current user data fetched on load.
- **Loading State:** Disable the Submit button and display a `<Loader2 className="animate-spin" />` icon inside it during API flight.
- **Success State:** Display a green Shadcn Toast notification: "Profile updated successfully."
- **Error State:** Inline red validation text under inputs for form errors. Global API errors display a destructive Toast banner.

## 3. Interaction & Event Handling

- **"Save Changes" Button:**
  - **Trigger:** On Click / Form Submit.
  - **Action:** Validate that `name` is not empty and <= 50 characters. Execute HTTP PUT request.
  - **Success Outcome:** Refresh local state data, disable loading spinner, show success toast.
  - **Failure Outcome:** Enable button, show specific error message from server response.

## 4. API Contract (Data Mapping)

### Frontend Request (Client -> API)

- **Method:** PUT
- **Endpoint:** `/api/v1/user/profile`
- **Payload Structure (JSON):**

```json
{
  "name": "Jane Doe",
  "avatarUrl": "https://example.com"
}
```

### Backend Response (API -> Client)

- **Success Status:** 200 OK
- **Success Payload (JSON):**

```json
{
  "success": true,
  "message": "Profile updated",
  "user": {
    "id": "usr_987",
    "name": "Jane Doe",
    "email": "jane.doe@example.com",
    "avatarUrl": "https://example.com",
    "updatedAt": "2026-05-20T16:15:00Z"
  }
}
```

- **Error Statuses:**
  - `400 Bad Request` (Validation failed: Name too long)
  - `401 Unauthorized` (Invalid or expired session token)

## 5. System Prompt For AI Generation

> **AI Instruction:** Act as a Senior Full-Stack Engineer. Read the Figma frame layout structure via MCP. Generate a responsive React component using Tailwind and Shadcn UI based on this spec. Then, write the corresponding Express.js backend route using Zod to validate the incoming payload against the schema defined in Section 4. Ensure correct TypeScript types are shared or aligned between frontend and backend.
