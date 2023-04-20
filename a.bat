@echo off
:top
git add .
git commit -a
rem git rebase --continue
git rebase --skip
rem sleep 1
goto top