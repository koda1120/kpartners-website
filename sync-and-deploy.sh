#!/bin/bash
# Kパートナーズ ウェブサイト 同期＆デプロイスクリプト

echo "ファイルを同期中..."
cp /home/tomokiai/index.html /home/tomokiai/kpartners-website/
cp /home/tomokiai/about.html /home/tomokiai/kpartners-website/
cp /home/tomokiai/service.html /home/tomokiai/kpartners-website/
cp /home/tomokiai/contact.html /home/tomokiai/kpartners-website/

echo "デプロイを開始します..."
cd /home/tomokiai/kpartners-website
netlify deploy --prod
echo "デプロイ完了！"
echo "URL: https://comfy-speculoos-507fa5.netlify.app"
