# Kパートナーズ ウェブサイト 開発メモ

## 今日決めた重要な設計方針（2026-01-21）

### 受付時間
- **電話受付時間**: 平日 10:00～19:00
- **対象箇所**: contact.html, thanks.html（統一済み）

---

## 過去の設計方針（2026-01-20）

### DNS・メール設定
- **ネームサーバー**: お名前.comのレンタルサーバー用（ns-rs1/rs2.gmoserver.jp）を使用
- **サイトホスティング**: Netlify（カスタムドメイン k-partners.online）
- **メール**: お名前メール（info@k-partners.online）
- **DNS設定場所**: お名前メールのレンタルサーバー側DNS設定画面で管理

### フォームサービス
- **採用**: Web3Forms（月250件まで無料）
- **理由**: FormSubmitからのメールがお名前メールに届かない問題があったため移行
- **アクセスキー**: 01992473-3273-4649-88c2-b1aef846be80

---

## 解決した問題とその方法

### 問題3: 受付時間の統一（2026-01-21）
- **内容**: 受付時間が「平日 9:00 - 18:00」だった
- **解決**: 「平日 10:00～19:00」に変更（contact.html, thanks.htmlの2箇所）

### 問題1: サイト表示とメール送受信が同時に動かない（2026-01-20）
- **原因**: お名前.comのネームサーバー設定とDNSレコード設定の関係
  - 01~04.dnsv.jp → サイト✓ メール✗
  - ns-rs1/rs2.gmoserver.jp → サイト✗ メール✓
- **解決**: レンタルサーバー側のDNS設定画面でNetlify用レコードを追加
  - Aレコード: k-partners.online → 75.2.60.5
  - CNAME: www.k-partners.online → kpartners-official.netlify.app

### 問題2: FormSubmitからのメールがお名前メールに届かない
- **原因**: FormSubmitのサーバーからのメールがお名前メール側でブロック/スパム判定
- **解決**: Web3Formsに移行（contact.html更新済み）

---

## 次回やるべきこと

1. **Web3Formsのメール到達確認**
   - テスト送信済み（2026-01-21）、thanks.htmlへのリダイレクトは成功
   - info@k-partners.online にメールが届いているか確認する
   - 届いていない場合: Web3Forms管理画面で送信ログを確認

2. **レスポンシブ表示確認**
   - スマホ・タブレットでの表示チェック
   - 各ページ（index, about, service, contact, thanks）を確認

---

## 技術情報

### 現在のDNSレコード（お名前メール側で設定）
| タイプ | ホスト名 | 値 |
|--------|----------|-----|
| A | k-partners.online | 75.2.60.5 |
| CNAME | www.k-partners.online | kpartners-official.netlify.app |
| MX | k-partners.online | mail1016.onamae.ne.jp |
| TXT | k-partners.online | v=spf1 include:_spf.onamae.ne.jp ~all |

### デプロイ方法
```bash
git add . && git commit -m "メッセージ" && git push
```
→ Netlifyが自動でビルド・デプロイ
