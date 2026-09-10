# PRP（Product Requirements Prompt）テンプレート

> タスク単位でAIへ渡す指示書です。1タスク = 1ファイルで管理します。
> ファイル名例：`prp-SCR-003-customer-list.md`

---

```markdown
# タスク：（タスク名）

## 概要

（何を実装するか1〜2文で）

## 対象ファイル

- `src/pages/CustomerList.tsx`（新規作成）
- `src/api/customers.ts`（既存ファイルに追記）

## 既存コードの参照

<!-- 実装前に読んでおくべき既存ファイル・関数・パターンを明示する -->

- `src/components/ui/DataTable.tsx` — 既存のテーブルコンポーネント（流用する）
- `src/api/products.ts` — 類似APIクライアント実装のパターン（参考にする）
- `src/hooks/usePagination.ts` — 既存のページネーションフック（そのまま使う）

## 参照する設計書

- [画面設計書 SCR-003](../tpl/screen-design.md)
- [API仕様書 GET /customers](../tpl/api-spec.md)
- [DB設計書 customers テーブル](../tpl/db-design.md)

## 受け入れ条件（Acceptance Criteria）

- [ ] 顧客名で部分一致検索できる
- [ ] 検索結果は20件/ページでページネーション表示される
- [ ] 0件の場合は「該当する顧客が見つかりません」と表示される
- [ ] 各行の「編集」ボタンで詳細画面に遷移できる
- [ ] ローディング中はスピナーを表示する

## 技術仕様

- コンポーネント名：`CustomerList`
- 使用API：`GET /api/customers?name=〇〇&page=1&limit=20`
- 状態管理：Zustand（`useCustomerStore`）
- バリデーション：不要（検索は任意入力）

## 実装のヒント

<!-- 使うべきライブラリ・パターン・既知の落とし穴など、実装者（AI）に渡す正の情報を記載する -->
<!-- 「禁止事項」は後のセクションに書く。ここはポジティブなガイダンス専用 -->

- ページネーションには既存の `usePagination` フック（`src/hooks/usePagination.ts`）を使う
- ローディング状態の表示には `<Spinner />` コンポーネント（`src/components/ui/Spinner.tsx`）を流用する
- API エラー表示は `useErrorToast()` フック（`src/hooks/useErrorToast.ts`）で統一する
- 日付フォーマットは `date-fns/format` を使う（`dayjs` は使わない）

## このタスク固有の禁止事項

<!-- CLAUDE.md の共通禁止事項に加え、このタスク特有の制約を記載 -->

- 既存の `DataTable` コンポーネントを改変しない（新コンポーネントで包む）
- `useEffect` で直接fetchしない（`useCustomerStore` のactionを通す）
- インラインスタイルを使用しない

## 制約・注意事項

- 既存の `Button` コンポーネントを流用する
- デザインは `src/styles/tokens.css` の CSS 変数を使用する
- `any` 型を使用しない

## テスト要件

- 検索結果が正しく表示されるユニットテストを作成する
- 0件時の表示をテストする
- ページネーション動作をテストする

## 完了後のアクション

<!-- 実装完了後に必ず実施する手順 -->

1. `code-reviewer` SubAgentでコードレビューを実行する
2. `security-reviewer` SubAgentでセキュリティチェックを実行する（入力処理がある場合）
3. `/commit` スキルでコミットメッセージを生成してコミットする
4. PRを作成し `/review-pr` スキルでレビュー内容を確認する
5. このPRPファイルの受け入れ条件をすべてチェック済みにする
```

---
## 🛑 HUMAN GATE (Approval Required)
> [!WARNING]
> **AI MUST STOP HERE** and wait for explicit human approval (e.g., "APPROVE", "Proceed") before making any code modifications based on this PRP.

