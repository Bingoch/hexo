# 部署
hexo clean
hexo generate
cp -R public/* deploy/Bingoch.github.io
cd deploy/Bingoch.github.io
git remote remove origin
git remote add git@github.com:Bingoch/Bingoch.github.io.git
git add .
git commit -m "update"
git push origin master

# 同步项目到github
cd ../../..
git remote remove origin
git remote add git@github.com:Bingoch/hexo.git
git add .
git commit -m "update blog files"
git push origin master
