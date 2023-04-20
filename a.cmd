@echo off
:top
git add .
git commit -a;git rebase --continue
sleep 1
goto top