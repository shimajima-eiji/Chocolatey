git add -A
git commit "Auto Update for Backup"

git branch tmp
git checkout master
git merge tmp
git push origin master
