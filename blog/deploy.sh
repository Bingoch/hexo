hexo clean
hexo generate
cp -R public/* deploy/Bingoch.github.io
cd deploy/Bingoch.github.io
git add .
git commit -m “update”
git push origin master