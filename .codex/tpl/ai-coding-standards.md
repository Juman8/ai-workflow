# AI Coding Standards（AIコーディング規約）

| 項目 | 内容 |
|------|------|
| プロジェクト名 | |
| バージョン | |
| 作成日 | |
| 作成者 | |

> このファイルはAIが守るべきコーディングルールを定義します。CLAUDE.mdと合わせて利用してください。

---

## 1. 言語・フレームワーク共通

### 1-1. 基本方針

- コードは読みやすさを優先する（パフォーマンス最適化は必要になってから行う）
- 関数は1つのことだけを行う（単一責任の原則）
- 関数は50行以内に収める
- ファイルは800行以内に収める
- マジックナンバーは定数に定義する
- `any` 型の使用を禁止する（TypeScriptの場合）

### 1-2. 命名規則

| 対象 | 規則 | 例 |
|------|------|-----|
| 変数 | camelCase | `userName`, `totalPrice` |
| 定数 | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| 関数 | camelCase（動詞始まり） | `getUser()`, `createOrder()` |
| クラス | PascalCase | `UserService`, `OrderRepository` |
| ファイル | kebab-case | `user-service.ts`, `order-repository.ts` |
| コンポーネント | PascalCase | `UserList.tsx`, `OrderForm.tsx` |

### 1-3. APIエンドポイント命名規則

- リソース名は**複数形の名詞**を使用する（動詞禁止）
- 階層は `/<リソース>/<id>/<サブリソース>` の形式にする
- バージョンプレフィックス `/api/v1/` を必ず付ける

| 操作 | メソッド | パス例 | 禁止パターン |
|------|---------|--------|------------|
| 一覧取得 | GET | `/api/v1/users` | `/api/v1/getUsers` ❌ |
| 1件取得 | GET | `/api/v1/users/:id` | `/api/v1/user/:id` ❌ |
| 作成 | POST | `/api/v1/users` | `/api/v1/createUser` ❌ |
| 更新 | PUT/PATCH | `/api/v1/users/:id` | `/api/v1/updateUser` ❌ |
| 削除 | DELETE | `/api/v1/users/:id` | `/api/v1/deleteUser` ❌ |
| サブリソース | GET | `/api/v1/users/:id/orders` | `/api/v1/getUserOrders` ❌ |

### 1-3. コメント

- 「何をしているか」ではなく「なぜそうしているか」をコメントに書く
- コメントは英語または日本語で統一する
- 自明なコードにコメントを付けない

```typescript
// Bad: 何をしているかを書いたコメント
// ユーザーを取得する
const user = await getUser(userId);

// Good: なぜそうしているかを書いたコメント
// キャッシュが存在する場合はDBを叩かずにキャッシュを返す
const user = cache.get(userId) ?? await getUser(userId);
```

---

## 2. TypeScript / JavaScript

### 2-1. 型定義

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

### 2-2. 非同期処理

```typescript
// Bad: コールバック地獄
fetchUser(id, (user) => {
  fetchOrders(user.id, (orders) => { ... });
});

// Good: async/await
const user = await fetchUser(id);
const orders = await fetchOrders(user.id);
```

### 2-3. エラーハンドリング

```typescript
// Bad: エラーを無視する
try {
  await saveUser(user);
} catch (_) {}

// Good: エラーをログに記録してユーザーに通知する
try {
  await saveUser(user);
} catch (error) {
  logger.error('ユーザー保存に失敗しました', { userId: user.id, error });
  throw new AppError('保存に失敗しました。再度お試しください。');
}
```

### 2-4. イミュータブルパターン

```typescript
// Bad: 既存オブジェクトを直接変更する
user.name = 'New Name';

// Good: 新しいオブジェクトを返す
const updatedUser = { ...user, name: 'New Name' };
```

---

## 3. React / フロントエンド

### 3-1. コンポーネント設計

- コンポーネントは表示（Presentational）と ロジック（Container）を分離する
- Props は必要最小限にする
- `useEffect` の依存配列を省略しない

```tsx
// Bad: ロジックと表示が混在
function UserList() {
  const [users, setUsers] = useState([]);
  useEffect(() => { fetch('/api/users').then(...) }, []);
  return <ul>{users.map(u => <li>{u.name}</li>)}</ul>;
}

// Good: ロジックをカスタムフックに分離
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

### 3-2. 禁止事項

- `dangerouslySetInnerHTML` を使用しない（XSSリスク）
- インラインスタイルを多用しない（デザイントークンを使用する）
- コンポーネントを1ファイルに複数定義しない（エクスポートするコンポーネントは1つ）

---

## 4. バックエンド（Node.js / Express）

### 4-1. APIルーター

```typescript
// Bad: ルーターに直接ビジネスロジックを書く
router.get('/users', async (req, res) => {
  const users = await db.query('SELECT * FROM users');
  res.json(users);
});

// Good: ビジネスロジックをサービス層に分離する
router.get('/users', authenticate, async (req, res) => {
  const users = await userService.findAll();
  res.json({ data: users });
});
```

### 4-2. バリデーション

```typescript
// Bad: バリデーションなし
router.post('/users', async (req, res) => {
  await createUser(req.body);
});

// Good: Zodでバリデーション
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

## 5. データベース

### 5-1. クエリ

```typescript
// Bad: SQLインジェクションの危険
const users = await db.query(`SELECT * FROM users WHERE name = '${name}'`);

// Good: パラメータ化クエリ
const users = await db.query('SELECT * FROM users WHERE name = $1', [name]);
```

### 5-2. トランザクション

- 複数のDB操作は必ずトランザクションでまとめる
- 失敗した場合はロールバックする

---

## 6. セキュリティ

- ハードコードされた認証情報・APIキーを含めない
- ユーザー入力は必ずバリデーションする
- 認証が必要なエンドポイントには認証ミドルウェアを設ける
- `console.log` を本番コードに残さない（`logger` を使用する）
- 機密情報をレスポンスに含めない（パスワードハッシュなど）

---

## 7. リンター・フォーマッター

> このプロジェクトのリント・フォーマット設定は以下のファイルで管理する。
> AIが自動生成したコードも **必ずこれらの設定に従うこと**。

| ツール | 設定ファイル | 適用タイミング |
|--------|------------|--------------|
| ESLint | `.eslintrc.js` / `.eslintrc.json` | コミット前・CIで自動チェック |
| Prettier | `.prettierrc` / `prettier.config.js` | ファイル保存時・コミット前 |
| Stylelint | `.stylelintrc` | CSSファイル編集時 |

**AIへの指示：** コード生成後に以下を実行してフォーマットを確認すること。

```bash
npm run lint       # ESLint チェック
npm run format     # Prettier 自動修正
```

既存の設定を変更・上書きしないこと。新しいルールの追加はレビュー後に行う。

---

## 8. テスト

- 新機能はテストを先に書く（TDD）
- カバレッジ 80% 以上を維持する
- テストファイルは対象ファイルと同じディレクトリに配置する（`*.test.ts`）
- モックは最小限にする（統合テストでは実DBを使用する）
