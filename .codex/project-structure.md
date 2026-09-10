# マルチリポジトリ構成ガイドライン

AI駆動開発におけるインフラ・API・Web・スマホの分割リポジトリ構成と、共有ドキュメントの管理方法をまとめたガイドラインです。

---

## 全体像

```
org/
├── project-docs/          # 共有仕様書（全リポジトリの参照元）
├── project-infra/         # インフラ（Terraform / CDK / K8s）
├── project-api/           # バックエンドAPI
├── project-web/           # Webフロントエンド
└── project-app/           # スマホアプリ（iOS/Android）
```

---

## `project-docs/`（共有仕様書）

全リポジトリが参照する仕様書の単一ソース。`tpl/` のテンプレートをコピーして各ファイルを作成します。

```
project-docs/
├── README.md                              # 仕様書一覧・更新ルール
│
├── requirements/                          # フェーズ1：要件定義
│   ├── prd.md                             # tpl/prd.md から作成
│   ├── srs.md                             # tpl/srs.md から作成
│   ├── business-flow.md                   # tpl/business-flow.md から作成
│   ├── migration-requirements.md          # tpl/migration-requirements.md から作成（移行あり）
│   └── operations-requirements.md        # tpl/operations-requirements.md から作成
│
├── estimate/                              # フェーズ1.5：工数見積
│   └── estimate.md                        # tpl/estimate.md から作成
│
├── design/                                # フェーズ2：設計
│   ├── architecture.md                    # tpl/architecture.md から作成
│   ├── db-design.md                       # tpl/db-design.md から作成
│   ├── api-spec.md                        # tpl/api-spec.md から作成 ★全リポジトリ共有
│   ├── screen-design/
│   │   ├── web/                           # tpl/screen-design.md から作成（Web用）
│   │   │   └── screen-design.md
│   │   └── app/                           # tpl/screen-design.md から作成（スマホ用）
│   │       └── screen-design.md
│   └── adr/                               # tpl/adr.md から作成
│       ├── ADR-001-api-framework.md
│       └── ADR-002-mobile-framework.md
│
├── sprint/                                # スプリント管理（アジャイル）
│   ├── sprint-backlog.md                  # tpl/sprint-backlog.md から作成
│   ├── retrospective.md                   # tpl/retrospective.md から作成
│   ├── issue-tracker.md                   # tpl/issue-tracker.md から作成
│   └── meeting-minutes/                   # tpl/meeting-minutes.md から作成
│       └── YYYY-MM-DD.md
│
├── ai-dev/                                # フェーズ3：AI開発準備
│   ├── ai-coding-standards.md             # tpl/ai-coding-standards.md から作成
│   └── ai-metrics.md                      # tpl/ai-metrics.md から作成
│
├── cross-repo/                            # 複数リポジトリにまたがる横断タスク
│   └── TASK-015-add-search-api.md
│
├── testing/                               # フェーズ5：テスト
│   ├── test-plan.md                       # tpl/test-plan.md から作成
│   ├── test-cases.md                      # tpl/test-cases.md から作成
│   ├── test-report.md                     # tpl/test-report.md から作成
│   └── bug-tracker.md                     # tpl/bug-tracker.md から作成
│
└── delivery/                              # フェーズ6：納品
    ├── release-notes.md                   # tpl/release-notes.md から作成
    ├── user-manual.md                     # tpl/user-manual.md から作成
    ├── admin-manual.md                    # tpl/admin-manual.md から作成
    └── acceptance.md                      # tpl/acceptance.md から作成
```

### テンプレート → 仕様書の対応表

| 仕様書 | 使用テンプレート | 作成フェーズ |
|--------|---------------|-----------|
| `requirements/prd.md` | `tpl/prd.md` | フェーズ1 |
| `requirements/srs.md` | `tpl/srs.md` | フェーズ1 |
| `requirements/business-flow.md` | `tpl/business-flow.md` | フェーズ1 |
| `requirements/migration-requirements.md` | `tpl/migration-requirements.md` | フェーズ1（移行あり） |
| `requirements/operations-requirements.md` | `tpl/operations-requirements.md` | フェーズ1 |
| `estimate/estimate.md` | `tpl/estimate.md` | フェーズ1.5 |
| `design/architecture.md` | `tpl/architecture.md` | フェーズ2 |
| `design/db-design.md` | `tpl/db-design.md` | フェーズ2 |
| `design/api-spec.md` | `tpl/api-spec.md` | フェーズ2 |
| `design/screen-design/` | `tpl/screen-design.md` | フェーズ2 |
| `design/adr/` | `tpl/adr.md` | フェーズ2 |
| `sprint/sprint-backlog.md` | `tpl/sprint-backlog.md` | スプリント毎 |
| `sprint/retrospective.md` | `tpl/retrospective.md` | スプリント毎 |
| `sprint/issue-tracker.md` | `tpl/issue-tracker.md` | 全期間 |
| `sprint/meeting-minutes/` | `tpl/meeting-minutes.md` | 全期間 |
| `ai-dev/ai-coding-standards.md` | `tpl/ai-coding-standards.md` | フェーズ3 |
| `ai-dev/ai-metrics.md` | `tpl/ai-metrics.md` | フェーズ3 |
| `testing/test-plan.md` | `tpl/test-plan.md` | フェーズ5 |
| `testing/test-cases.md` | `tpl/test-cases.md` | フェーズ5 |
| `testing/test-report.md` | `tpl/test-report.md` | フェーズ5 |
| `testing/bug-tracker.md` | `tpl/bug-tracker.md` | フェーズ5 |
| `delivery/release-notes.md` | `tpl/release-notes.md` | フェーズ6 |
| `delivery/user-manual.md` | `tpl/user-manual.md` | フェーズ6 |
| `delivery/admin-manual.md` | `tpl/admin-manual.md` | フェーズ6 |
| `delivery/acceptance.md` | `tpl/acceptance.md` | フェーズ6 |

### 仕様書オーナーと更新ルール

| 仕様書 | オーナー | 更新トリガー |
|--------|---------|------------|
| `prd.md` / `srs.md` | PM・要件担当 | 要件変更時 |
| `api-spec.md` | APIチーム | エンドポイント追加・変更時 |
| `db-design.md` | APIチーム | テーブル・カラム変更時 |
| `architecture.md` | インフラ・APIチーム | 構成変更時 |
| `screen-design/web/` | Webチーム | 画面追加・変更時 |
| `screen-design/app/` | モバイルチーム | 画面追加・変更時 |
| `bug-tracker.md` | 全チーム | バグ発生・解決時 |
| `sprint-backlog.md` | スクラムマスター | スプリント毎 |

### 仕様書の同期フロー

```
project-docs の api-spec.md が更新される
    │
    ▼
CI（sync-docs.yml）が自動実行
    ├── project-api/docs/api-spec.local.md を更新してPR作成
    ├── project-web/docs/api-spec.local.md を更新してPR作成
    └── project-app/docs/api-spec.local.md を更新してPR作成
    │
    ▼
各チームがPRをレビュー → マージ
    │
    ▼
AIは各リポジトリの docs/api-spec.local.md を参照して実装
```

---

## `project-infra/`

```
project-infra/
├── CLAUDE.md                              # tpl/claude-md.md から作成（インフラ専用）
├── .claudeignore                          # tpl/claudeignore-sample.md を参考に作成
│
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── terraform.tfvars
│   │   ├── stg/
│   │   └── prd/
│   └── modules/
│       ├── vpc/
│       ├── rds/
│       ├── ecs/
│       └── cdn/
│
├── k8s/                                   # Kubernetes使用の場合
│   ├── base/
│   └── overlays/
│
├── docs/                                  # インフラ固有ドキュメント（共有仕様書のコピー）
│   ├── architecture.local.md              # ← project-docs/design/architecture.md のコピー
│   ├── env-setup.md                       # tpl/env-setup.md から作成
│   └── operations-requirements.local.md   # ← project-docs/requirements/operations-requirements.md のコピー
│
├── prp/                                   # tpl/prp.md から作成（タスク単位）
│   ├── PRP-001-setup-vpc.md
│   └── PRP-002-setup-rds.md
│
└── .github/
    └── workflows/
        ├── terraform-plan.yml
        └── sync-docs.yml                  # project-docs からの同期
```

### CLAUDE.md（infra）の要点

```markdown
## 参照する共有仕様書
- システム構成：docs/architecture.local.md
- 非機能要件（SLA・スケーリング）：../project-docs/requirements/srs.md
- 運用要件：docs/operations-requirements.local.md

## このリポジトリの責務
- VPC・RDS・ECS・CDNのプロビジョニング
- 環境（dev/stg/prd）の構成管理

## 他リポジトリとの境界
- アプリケーションコードの実装 → 各アプリリポジトリ

## 禁止事項
- アプリケーションコードをここに置かない
- 本番環境の変更は必ずplan確認後にapply
- 認証情報・シークレットをコードにハードコードしない
```

---

## `project-api/`

```
project-api/
├── CLAUDE.md                              # tpl/claude-md.md から作成（API専用）
├── .claudeignore                          # tpl/claudeignore-sample.md を参考に作成
│
├── src/
│   ├── routes/                            # APIルーター
│   ├── controllers/
│   ├── services/
│   ├── repositories/                      # DB操作
│   ├── models/                            # 型定義・スキーマ
│   └── middleware/                        # 認証・バリデーション
│
├── migrations/                            # DBマイグレーション
│
├── tests/
│   ├── unit/
│   ├── integration/
│   └── fixtures/
│
├── docs/                                  # 共有仕様書のローカルコピー（CIで同期）
│   ├── api-spec.local.md                  # ← project-docs/design/api-spec.md
│   ├── db-design.local.md                 # ← project-docs/design/db-design.md
│   └── srs.local.md                       # ← project-docs/requirements/srs.md
│
├── prp/                                   # tpl/prp.md から作成（タスク単位）
│   ├── PRP-001-user-auth.md
│   ├── PRP-002-customer-search.md
│   └── PRP-003-order-api.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── sync-docs.yml                  # api-spec.md の変更を project-docs へPR
```

### CLAUDE.md（api）の要点

```markdown
## 参照する共有仕様書
- API仕様：docs/api-spec.local.md
- DB設計：docs/db-design.local.md
- 非機能要件：docs/srs.local.md

## AIコーディング規約
- ../project-docs/ai-dev/ai-coding-standards.md に従うこと

## このリポジトリの責務
- REST API の実装（Node.js / Express）
- DB操作・ビジネスロジック

## 他リポジトリとの境界
- インフラ（RDS接続先・ECS設定）→ project-infra
- UI実装 → このリポジトリでは行わない

## 禁止事項
- フロントエンドのコードをここに置かない
- 環境変数を .env 以外にハードコードしない
```

---

## `project-web/`

```
project-web/
├── CLAUDE.md                              # tpl/claude-md.md から作成（Web専用）
├── .claudeignore                          # tpl/claudeignore-sample.md を参考に作成
│
├── src/
│   ├── app/                               # Next.js App Router or pages/
│   ├── components/
│   │   ├── ui/                            # 汎用コンポーネント
│   │   └── features/                      # 機能別コンポーネント
│   ├── hooks/
│   ├── lib/
│   │   └── api-client/                    # project-api への通信クライアント
│   ├── stores/                            # 状態管理
│   └── styles/
│
├── tests/
│   ├── unit/
│   ├── e2e/                               # Playwright
│   └── visual/                            # スクリーンショットテスト
│
├── docs/                                  # 共有仕様書のローカルコピー（CIで同期）
│   ├── screen-design.local.md             # ← project-docs/design/screen-design/web/
│   └── api-spec.local.md                  # ← project-docs/design/api-spec.md
│
├── prp/                                   # tpl/prp.md から作成（タスク単位）
│   ├── PRP-001-login-screen.md
│   └── PRP-002-customer-list.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── sync-docs.yml
```

### CLAUDE.md（web）の要点

```markdown
## 参照する共有仕様書
- 画面設計：docs/screen-design.local.md
- API仕様：docs/api-spec.local.md

## AIコーディング規約
- ../project-docs/ai-dev/ai-coding-standards.md に従うこと

## このリポジトリの責務
- Web UI の実装（Next.js / React）
- project-api との通信（src/lib/api-client/）

## 他リポジトリとの境界
- API実装 → project-api
- インフラ → project-infra
- スマホUI → project-app（コンポーネントは共有しない）

## 禁止事項
- APIのビジネスロジックをフロントに書かない
- src/lib/api-client/ 以外で直接fetchを呼ばない
```

---

## `project-app/`

```
project-app/
├── CLAUDE.md                              # tpl/claude-md.md から作成（モバイル専用）
├── .claudeignore                          # tpl/claudeignore-sample.md を参考に作成
│
├── src/                                   # Flutter or React Native
│   ├── screens/                           # 画面
│   ├── components/                        # 共通コンポーネント
│   ├── navigation/                        # 画面遷移
│   ├── services/
│   │   └── api-client/                    # project-api への通信クライアント
│   ├── stores/                            # 状態管理
│   └── assets/
│
├── ios/
├── android/
│
├── tests/
│   ├── unit/
│   └── e2e/                               # Detox or Maestro
│
├── docs/                                  # 共有仕様書のローカルコピー（CIで同期）
│   ├── screen-design.local.md             # ← project-docs/design/screen-design/app/
│   └── api-spec.local.md                  # ← project-docs/design/api-spec.md
│
├── prp/                                   # tpl/prp.md から作成（タスク単位）
│   ├── PRP-001-login-screen.md
│   └── PRP-002-push-notification.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── sync-docs.yml
```

### CLAUDE.md（app）の要点

```markdown
## 参照する共有仕様書
- 画面設計：docs/screen-design.local.md
- API仕様：docs/api-spec.local.md

## AIコーディング規約
- ../project-docs/ai-dev/ai-coding-standards.md に従うこと

## このリポジトリの責務
- iOS / Android アプリの実装（Flutter）
- project-api との通信（src/services/api-client/）

## 他リポジトリとの境界
- API実装 → project-api
- Web UI → project-web（コンポーネントは共有しない）

## 禁止事項
- プラットフォーム固有コードを src/ 直下に書かない
- APIキーをソースコードにハードコードしない
```

---

## 横断タスクの扱い

API追加など複数リポジトリにまたがるタスクは `project-docs/cross-repo/` で一元管理します。

```markdown
# TASK-015-add-search-api.md（横断タスク指示書の例）

## 概要
顧客検索APIの追加（project-api・project-web・project-appの3リポジトリに影響）

## 各リポジトリのタスク
- project-api：GET /api/customers?q= エンドポイントの追加（prp/PRP-015参照）
- project-web：検索画面の追加（prp/PRP-023参照）
- project-app：検索画面の追加（prp/PRP-018参照）

## 実装順序
1. project-api でエンドポイントを実装
2. project-docs/design/api-spec.md を更新
3. CI が project-web / project-app に api-spec.local.md の更新PRを作成
4. 各チームがPRをマージ後にUI実装を開始
```

---

## マルチリポジトリ × AI開発の注意点

| 課題 | 対策 |
|------|------|
| AIが他リポジトリのコードを知らない | `CLAUDE.md` に境界と参照先を明記する |
| API仕様書が各リポジトリでズレる | `project-docs` を単一ソースとし、CIで各リポジトリに同期する |
| PRPを作るときに依存関係がわかりにくい | PRPに「このタスクが依存するリポジトリ・ファイル」を明記する |
| レビュアーがまたぐ変更を把握しにくい | `issue-tracker.md` に影響リポジトリを記載する |
| CLAUDE.mdをどのリポジトリから更新すべきかわからない | コード変更後、そのリポジトリの `CLAUDE.md` を即時更新する |
| AI活用の効果が見えない | `ai-metrics.md` でスプリント単位の指標を記録する |

---

## チェックリスト

### 新規プロジェクト立ち上げ時

**`project-docs` の準備**
- [ ] `tpl/prd.md` をコピーして `requirements/prd.md` を作成したか
- [ ] `tpl/srs.md` をコピーして `requirements/srs.md` を作成したか
- [ ] `tpl/architecture.md` をコピーして `design/architecture.md` を作成したか
- [ ] `tpl/db-design.md` をコピーして `design/db-design.md` を作成したか
- [ ] `tpl/api-spec.md` をコピーして `design/api-spec.md` を作成したか
- [ ] `tpl/screen-design.md` をコピーして `design/screen-design/web/` と `design/screen-design/app/` を作成したか
- [ ] `tpl/ai-coding-standards.md` をコピーして `ai-dev/ai-coding-standards.md` を作成したか
- [ ] `tpl/ai-metrics.md` をコピーして `ai-dev/ai-metrics.md` を作成したか
- [ ] `tpl/sprint-backlog.md` をコピーして `sprint/sprint-backlog.md` を作成したか
- [ ] `tpl/bug-tracker.md` をコピーして `testing/bug-tracker.md` を作成したか

**各アプリリポジトリの準備**
- [ ] `tpl/claude-md.md` をコピーして `CLAUDE.md` を作成・カスタマイズしたか
- [ ] `tpl/claudeignore-sample.md` を参考に `.claudeignore` を作成したか
- [ ] `docs/` に共有仕様書のローカルコピーを配置したか
- [ ] CI で `project-docs` からの同期ワークフローを設定したか
- [ ] PRP作成時に `tpl/prp.md` をテンプレートとして使っているか

### スプリント開始時

- [ ] `tpl/sprint-backlog.md` の新スプリント行を追加したか
- [ ] 各ユーザーストーリーに `tpl/prp.md` をもとにPRPを作成したか
- [ ] `tpl/estimate.md` でSP見積もりを更新したか

### API仕様変更時

- [ ] `project-docs/design/api-spec.md` を更新したか
- [ ] CI が project-api / project-web / project-app に同期PRを作成したか
- [ ] 各チームが同期PRをレビュー・マージしたか

### スプリント終了時

- [ ] `tpl/retrospective.md` をもとにレトロスペクティブを記録したか
- [ ] git log を AI に渡して `design/api-spec.md` / `design/db-design.md` を差分更新したか
- [ ] `tpl/test-report.md` をもとにテスト結果報告書を更新したか
- [ ] `tpl/bug-tracker.md` のバグステータスを更新したか
- [ ] `ai-metrics.md` にスプリントの実績を記録したか

### リリース・納品時

- [ ] `tpl/test-report.md` をもとにテスト結果報告書を最終化したか
- [ ] `tpl/user-manual.md` / `tpl/admin-manual.md` をもとにマニュアルを作成したか
- [ ] `tpl/release-notes.md` をもとにリリースノートを作成したか
- [ ] `tpl/acceptance.md` をもとに検収確認書を作成・署名取得したか
