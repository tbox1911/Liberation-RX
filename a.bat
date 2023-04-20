@echo off
:top
git add .
git commit -a;git rebase --continue
rem sleep 1
goto top