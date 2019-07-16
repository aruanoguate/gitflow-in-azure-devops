REM To unstage all files
git config --global alias.unstage "reset HEAD --"

REM To clean all branches already merged
REM This is pending to be implemented on a Windows way
REM git config --global alias.clean "git branch --merged | grep -v "\*" | grep -Ev "(\*|master)" | xargs -n 1 git branch -d"
