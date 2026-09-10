# 環境構築手順書

| 項目 | 内容 |
|------|------|
| プロジェクト名 | |
| 対象環境 | ローカル開発環境 |
| 作成日 | |
| 作成者 | |

---

## 前提条件

| ソフトウェア | バージョン | 確認コマンド |
|------------|-----------|------------|
| Node.js | 20.x 以上 | `node -v` |
| npm / pnpm | 最新版 | `npm -v` |
| Git | 最新版 | `git --version` |
| Docker | 最新版 | `docker -v` |
| PostgreSQL | 15.x 以上 | `psql --version` |

---

## 1. リポジトリのクローン

```bash
git clone https://github.com/your-org/project-name.git
cd project-name
```

---

## 2. 依存パッケージのインストール

```bash
npm install
# または
pnpm install
```

---

## 3. 環境変数の設定

`.env.example` をコピーして `.env` を作成します。

```bash
cp .env.example .env
```

`.env` を編集して各値を設定します。

```env
# アプリケーション
APP_PORT=3000
APP_ENV=development

# データベース
DATABASE_URL=postgresql://postgres:password@localhost:5432/dbname

# 認証
JWT_SECRET=your-secret-key-here
JWT_EXPIRES_IN=7d

# 外部サービス（必要な場合）
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
```

> **注意：** `.env` ファイルはGit管理対象外です。機密情報を含むため、社外に共有しないでください。

---

## 4. データベースのセットアップ

### 4-1. DBの作成

```bash
# PostgreSQL に接続してDBを作成
psql -U postgres -c "CREATE DATABASE dbname;"
```

### 4-2. マイグレーションの実行

```bash
npm run db:migrate
# または
npx prisma migrate dev
```

### 4-3. 初期データの投入（シード）

```bash
npm run db:seed
```

---

## 5. 開発サーバーの起動

```bash
npm run dev
```

ブラウザで `http://localhost:3000` を開いてアプリケーションが表示されることを確認します。

---

## 6. テストの実行

```bash
# 全テスト実行
npm test

# ユニットテストのみ
npm run test:unit

# E2Eテスト
npm run test:e2e
```

---

## 7. ビルド

```bash
npm run build
```

---

## 8. Dockerを使った起動（オプション）

```bash
# コンテナの起動
docker compose up -d

# ログの確認
docker compose logs -f

# コンテナの停止
docker compose down
```

---

## 9. トラブルシューティング

### ポートが既に使用されている

```bash
# 使用中のプロセスを確認（macOS / Linux）
lsof -i :3000

# プロセスを終了
kill -9 <PID>
```

### DBに接続できない

- `DATABASE_URL` の設定が正しいか確認する
- PostgreSQLが起動しているか確認する  
  ```bash
  pg_isready
  ```

### npm installが失敗する

```bash
# キャッシュをクリアして再実行
npm cache clean --force
npm install
```

---

## 10. 参考資料

| 資料 | URL |
|------|-----|
| プロジェクトREADME | README.md |
| API仕様書 | tpl/api-spec.md |
| DB設計書 | tpl/db-design.md |
