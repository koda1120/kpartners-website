# Kパートナーズ ウェブサイト 開発ドキュメント

## アカウント・サービス情報

| サービス | アカウント | 用途 |
|---------|-----------|------|
| GitHub | koda1120 (koda1120/kpartners-website) | ソースコード管理 |
| Netlify | IKEMEN LTD (ikemenltd@gmail.com) / チーム: IKEMEN | ホスティング・デプロイ |
| お名前.com | ドメイン・DNS管理 | k-partners.online |
| お名前メール | info@k-partners.online | 問い合わせ受信 |
| Web3Forms | アクセスキー: 01992473-3273-4649-88c2-b1aef846be80 | フォーム送信 |

### Netlify
- サイト名: kpartners-official
- Site ID: 7fa7787e-1a3e-4b21-a433-10a41bbf1d28
- Admin: https://app.netlify.com/projects/kpartners-official
- デプロイ: GitHub連携による自動デプロイ（masterブランチへのpush）

---

## サイト構成

| URL | 内容 | ディレクトリ |
|-----|------|-------------|
| k-partners.online | 公式HP | / (ルート) |
| portfolio.k-partners.online | ポートフォリオ | /portfolio/ |

サブドメインのルーティングは `netlify.toml` で設定。

### ファイル構成
```
kpartners-website/
├── index.html          ← トップページ
├── about.html          ← 会社概要
├── service.html        ← 事業内容
├── contact.html        ← お問い合わせ（Web3Forms）
├── thanks.html         ← フォーム送信完了
├── images/             ← 画像
├── netlify.toml        ← サブドメインルーティング設定
├── .netlify/           ← Netlifyローカル設定（Git管理外推奨）
└── portfolio/          ← ポートフォリオサイト
    ├── index.html
    ├── thanks.html
    └── 画像ファイル
```

---

## DNS設定（お名前メール レンタルサーバー側で管理）

| タイプ | ホスト名 | 値 |
|--------|----------|-----|
| A | k-partners.online | 75.2.60.5 |
| CNAME | www.k-partners.online | kpartners-official.netlify.app |
| CNAME | portfolio.k-partners.online | kodaprofile.netlify.app |
| TXT | subdomain-owner-verification | 4fc3bb6162e96054a7c4d6c07f8af41c |
| MX | k-partners.online | mail1016.onamae.ne.jp |
| TXT | k-partners.online | v=spf1 include:_spf.onamae.ne.jp ~all |

**ネームサーバー**: お名前メールのレンタルサーバー用（ns-rs1/rs2.gmoserver.jp）を使用。
dnsv.jpに変更するとメールが届かなくなるため注意。

---

## 設計方針

- **事業名表記**: 「AI・DX内製化支援」に統一
- **設立日表記**: 「2025年11月27日」に統一
- **営業時間**: 平日10:00〜18:00（土日祝日・年末年始を除く）
- **回答期間**: 通常3営業日
- **デザイン**: モダン・クリーン、アクセントカラー #3b82f6、primary #0f172a

---

## 過去に解決した問題

### サイト表示とメール送受信の両立（2026-01-20）
- **原因**: お名前.comのネームサーバー設定。dnsv.jp→サイトOK/メールNG、gmoserver.jp→逆
- **解決**: レンタルサーバー側DNS設定画面でNetlify用Aレコード・CNAMEを追加

### FormSubmitからのメール不達（2026-01-20）
- **原因**: お名前メール側でブロック/スパム判定
- **解決**: Web3Formsに移行

### Netlifyサブドメイン設定エラー（2026-01-27）
- **原因**: 親ドメインが別プロジェクトに登録済みのためサブドメインを別プロジェクトに設定不可
- **解決**: 同一リポジトリ・同一Netlifyプロジェクトに統合、netlify.tomlでルーティング

---

## デプロイ方法

```bash
git add . && git commit -m "メッセージ" && git push
```
Netlifyが自動でビルド・デプロイ（公式HP・ポートフォリオ両方）。

手動デプロイ:
```bash
netlify deploy --prod
```
