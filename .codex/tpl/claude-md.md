# CLAUDE.md（AI Context Document）テンプレート

> このファイルをプロジェクトルートに `CLAUDE.md` として配置してください。
> AIツール（Claude Code など）が自動的に読み込み、プロジェクトの文脈を理解します。

---

```markdown
# プロジェクト概要

（システムの目的を1〜2文で記載）

# 技術スタック

- Frontend: React + TypeScript
- Backend: Node.js + Express
- Database: PostgreSQL
- ORM: Prisma
- Testing: Jest + Playwright
- CI/CD: GitHub Actions

# ディレクトリ構成

src/
├── components/   # UIコンポーネント
├── pages/        # ページコンポーネント
├── api/          # APIルーター
├── db/           # DBスキーマ・マイグレーション
├── lib/          # 共通ユーティリティ
└── types/        # 型定義

docs/
├── prp/          # PRP（AI実装指示書）: prp-<画面ID>-<機能名>.md
└── tpl/          # ドキュメントテンプレート

# コーディング規約

- TypeScript の strict モードを使用
- 関数は50行以内に収める
- ファイルは800行以内に収める
- immutable パターンを使用（オブジェクトの直接変更禁止）
- エラーハンドリングを必ず実装する
- any 型の使用禁止

# 使用するライブラリ

- 状態管理: Zustand（Redux 禁止）
- フォーム: React Hook Form
- HTTP クライアント: Axios
- バリデーション: Zod

# 禁止事項

- console.log を本番コードに残さない
- ハードコードされた認証情報・APIキーを含めない
- SQL インジェクションの危険がある文字列結合クエリを書かない
- any 型を使用しない
- CLAUDE.md に記載のないライブラリを新規インストールしない

# セキュリティ

- ユーザー入力は必ずバリデーションを行う
- SQLはパラメータ化クエリを使用する
- 認証が必要なAPIには認証ガードを設ける

# テスト方針

- 新機能はテストを先に書く（TDD）
- カバレッジ 80% 以上を維持する
- E2E テストは Playwright で作成する

# ブランチ戦略

- `main`: 本番リリースブランチ（直接コミット禁止）
- `develop`: 開発統合ブランチ
- `feature/<画面ID>-<機能名>`: 機能開発ブランチ（例: `feature/SCR-003-customer-list`）
- `fix/<バグID>-<概要>`: バグ修正ブランチ（例: `fix/BUG-012-login-error`）
- PRはすべて `develop` へ向けて作成する

# SubAgent 設定

以下のSubAgentを用途に応じて活用する：

| SubAgent | 用途 | 起動タイミング |
|----------|------|--------------|
| code-reviewer | コードレビュー・品質チェック | 実装完了後・PR作成前 |
| security-reviewer | セキュリティ脆弱性チェック | 認証・入力処理変更時 |
| build-error-resolver | ビルドエラー解消 | ビルド失敗時 |
| tdd-guide | TDD実践支援 | 新機能・バグ修正時 |

# スキル（Skill）設定

| スキル | 用途 |
|--------|------|
| /commit | 差分分析・コミットメッセージ生成 |
| /review-pr | PRレビュー支援 |
| /plan | 実装計画書の作成 |
| /tdd | テスト駆動開発サイクル支援 |

# PRP（AI実装指示書）運用

- 1タスク = 1 PRPファイルで管理する
- 保存場所: `docs/prp/`
- ファイル名形式: `prp-<画面ID>-<機能名>.md`（例: `prp-SCR-003-customer-list.md`）
- 実装前に必ずPRPを作成・レビューしてから着手する

# .claudeignore 参照

トークン消費を抑えるため `.claudeignore` でAIが読まないファイルを指定する。
サンプル: `docs/tpl/claudeignore-sample.md` を参照。

# よく使うコマンド

<!-- プロジェクトでよく使うコマンドを記載する。AIが迷わず実行できるようにする -->

| コマンド | 説明 |
|---------|------|
| `npm run dev` | 開発サーバー起動 |
| `npm test` | ユニットテスト実行（Jest） |
| `npm run test:e2e` | E2Eテスト実行（Playwright） |
| `npm run build` | 本番ビルド |
| `npm run lint` | ESLint チェック |
| `npm run format` | Prettier フォーマット適用 |
| `npx prisma migrate dev` | DBマイグレーション実行（開発環境） |
| `npx prisma studio` | Prisma Studio（DBビジュアライザー）起動 |
| `npm run typecheck` | TypeScript 型チェック（`tsc --noEmit`） |

# プロジェクト固有の用語集

<!-- AIがドメイン用語を正しく理解できるよう定義する。曖昧な語は必ず記載する -->

| 用語 | 定義 | 補足 |
|------|------|------|
| 顧客 | このシステムにおける〇〇を指す | `customers` テーブルに対応 |
| 案件 | 〇〇の単位 | `projects` テーブルに対応 |
| （例）承認 | 管理者ロールが行う最終確認アクション | 「確認」とは異なる |
```
