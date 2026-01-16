#!/bin/bash
# Kパートナーズ ウェブサイト デプロイスクリプト

echo "デプロイを開始します..."
cd /home/tomokiai/kpartners-website
netlify deploy --prod
echo "デプロイ完了！"
