git add -A
git commit -m "Auto Update for Backup"

git branch -d tmp
git branch tmp
git checkout master
git merge tmp
git push https master
