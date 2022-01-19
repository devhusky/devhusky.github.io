#!/bin/bash
#

if [ $1 -z ]; then
	echo "请输入commit"
	exit
fi

if [ ! -f ./themes/next/_config.yml ]; then
	echo "./themes/next/_config.yml文件不存在"
	exit
fi

#将git秘钥替换，防止直接提交到git仓库上
sed -i '' 's/<client_id>/635b7cd2c27103bfabd9/g' ./themes/next/_config.yml
sed -i '' 's/<client_secret>/46e585c2bae1206fa16207c2caddfc53028cbc64/g' ./themes/next/_config.yml

git add .
git commit -m $1
git push origin gh-pages

sed -i '' 's/635b7cd2c27103bfabd9/<client_id>/g' ./themes/next/_config.yml
sed -i '' 's/46e585c2bae1206fa16207c2caddfc53028cbc64/<client_secret>/g' ./themes/next/_config.yml


