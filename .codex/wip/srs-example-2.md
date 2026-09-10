# Screen Spec: Account Profile Settings

## 1. Context & Tech Stack

- **Figma Link:** https://figma.com
- **Directory Pattern:** Next.js App Router (`src/app/dashboard/settings/page.tsx`)
- **Styling & Components:** Tailwind CSS + shadcn/ui
- **Form & Validation:** `react-hook-form` + `zod`
- **Data Fetching:** Fetch data via Server Component, Pass to Client Component form as props.

## 2. Component Hierarchy & shadcn/ui Mapping

- `SettingsPage` (`src/app/dashboard/settings/page.tsx` - Server Component)
  - `ProfileForm` (`components/profile-form.tsx` - `"use client"`)
    - `Card`, `CardHeader`, `CardTitle`, `CardDescription`, `CardContent`, `CardFooter`
    - `Form`, `FormField`, `FormItem`, `FormLabel`, `FormControl`, `FormMessage`
    - `Input` (for username)
    - `Button` (Submit button, variant: "default")

## 3. Zod Schema & API Contract

### Validation Schema (Zod)

```typescript
export const profileSchema = z.object({
  username: z
    .string()
    .min(2, { message: 'ユーザー名は2文字以上で入力してください。' })
    .max(30),
  bio: z.string().max(160).optional(),
})
```

### API Route (`src/app/api/user/profile/route.ts`)

- **Method:** PUT
- **Request Payload:**

```json
{
  "username": "tech_taro",
  "bio": "Next.jsとTailwind CSSを勉強中です。"
}
```

- **Success Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": "usr_123456",
    "username": "tech_taro",
    "bio": "Next.jsとTailwind CSSを勉強中です。",
    "updatedAt": "2026-05-20T09:00:00Z"
  }
}
```

## 4. UI States & Interactions

- **Initial State:** `SettingsPage` (Server) がDBからユーザーデータを取得し、`ProfileForm` (Client) の `initialData` プロップスに渡して `defaultValues` としてロード。
- **Loading State:** 送信中（`isSubmitting`）は、ボタンを無効化し、テキストを「保存中...」に変更して Lucide の `Loader2` スピナーを回す。
- **Success State:** `sonner`（または `useToast`）で「プロフィールを更新しました」とグリーンの通知を表示。`router.refresh()` を実行してサーバーデータを再検証。
- **Error State:** APIエラー（400/500系）が発生した場合、`toast({ variant: "destructive", title: "エラー", description: res.message })` を表示。

## 5. System Prompt For AI Generation

> **AI Instruction:** Act as a Senior Full-Stack Next.js Developer.
>
> 1. Create `src/app/api/user/profile/route.ts` using `NextResponse` to handle the PUT request, validate via Zod schema, and return the mocked JSON response.
> 2. Create `"use client"` component `src/components/profile-form.tsx` using shadcn/ui components (`Card`, `Form`, `Input`, `Button`). Implement form submission using `fetch` to the created API route.
> 3. Create `src/app/dashboard/settings/page.tsx` as a Server Component that passes initial mock data to `<ProfileForm />`.
>    Follow shadcn/ui best practices strictly (e.g., using `@/lib/utils` for `cn`).
