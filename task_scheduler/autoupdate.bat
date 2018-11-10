cd /d %~dp0

git add -A
git commit -m "Auto Update for Backup"

git branch tmp
git checkout master
git merge tmp
git branch -d tmp
git push https master
