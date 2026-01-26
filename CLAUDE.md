# Kパートナーズ ウェブサイト 開発メモ

## 今日決めた重要な設計方針（2026-01-27）

### ポートフォリオサイト統合
- **方針**: 公式HPと同一リポジトリ・同一Netlifyプロジェクトに統合
- **理由**: サブドメインを別プロジェクトに設定するとNetlifyでエラーが発生するため
- **構成**: portfolio/ディレクトリにポートフォリオを配置、netlify.tomlでルーティング

### サイト構成
| URL | 内容 | ディレクトリ |
|-----|------|-------------|
| k-partners.online | 公式HP | / (ルート) |
| portfolio.k-partners.online | ポートフォリオ | /portfolio/ |

### 表記統一
- **事業名**: 「AI・DX内製化支援」に統一（全ページ）
- **設立日**: 「2025年11月27日」に統一

---

## 過去の設計方針（2026-01-26）

### 営業時間・回答期間
- **営業時間**: 平日10:00〜18:00（土日祝日・年末年始を除く）
- **回答期間**: 通常3営業日
- **対象箇所**: contact.html, thanks.html, portfolio/thanks.html

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

### 問題6: Netlifyサブドメイン設定エラー（2026-01-27）
- **内容**: portfolio.k-partners.onlineを別Netlifyプロジェクト(kodaprofile)に設定しようとするとエラー
- **原因**: 親ドメインk-partners.onlineがkpartners-officialに登録済みのため
- **解決**: 同一リポジトリ・同一Netlifyプロジェクトに統合、netlify.tomlでルーティング

### 問題5: フッター不統一・リンク未実装（2026-01-27）
- **内容**: ページ間でフッター形式が異なる、事業内容リンクが機能しない
- **解決**: 全5ページでフッター統一、service.htmlにセクションid追加、scroll-margin-top設定

### 問題4: 表記不統一・未使用コード（2026-01-27）
- **内容**: 「AI・DX支援」と「AI・DX内製化支援」の混在、設立日の曖昧表記、未使用CSS/JS
- **解決**: 全ページで「AI・DX内製化支援」「2025年11月27日」に統一、未使用コード削除

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

1. **フッター年表示の更新**
   - 現在「© 2024」→「© 2026」に変更
   - 対象: portfolio/index.html, portfolio/thanks.html

2. **不要リソースの削除（任意）**
   - images/ヒーローセクション.png（未使用画像）
   - Netlify: kodaprofileプロジェクト（不要になった）
   - GitHub: koda-portfolioリポジトリ（不要になった）

3. **ポートフォリオのフォーム動作確認**
   - portfolio.k-partners.online からテスト送信
   - info@k-partners.online に届くか確認

4. **レスポンシブ表示確認**
   - スマホ・タブレットでの表示チェック
   - 公式HP全ページ + ポートフォリオ

---

## 技術情報

### 現在のDNSレコード（お名前メール側で設定）
| タイプ | ホスト名 | 値 |
|--------|----------|-----|
| A | k-partners.online | 75.2.60.5 |
| CNAME | www.k-partners.online | kpartners-official.netlify.app |
| CNAME | portfolio.k-partners.online | kodaprofile.netlify.app |
| TXT | subdomain-owner-verification | 4fc3bb6162e96054a7c4d6c07f8af41c |
| MX | k-partners.online | mail1016.onamae.ne.jp |
| TXT | k-partners.online | v=spf1 include:_spf.onamae.ne.jp ~all |

### ファイル構成
```
kpartners-website/
├── index.html, about.html, service.html, contact.html, thanks.html  ← 公式HP
├── images/
├── netlify.toml          ← サブドメインルーティング設定
└── portfolio/            ← ポートフォリオサイト
    ├── index.html, thanks.html
    └── 画像ファイル
```

### デプロイ方法
```bash
git add . && git commit -m "メッセージ" && git push
```
→ Netlifyが自動でビルド・デプロイ（公式HP・ポートフォリオ両方）
