#!/bin/bash

# To remove all branches already merged with the exception of master and develop
git fetch --all
git checkout master
git reset --hard origin/master
git checkout develop
git reset --hard origin/develop
git branch --merged | grep -v "\*" | grep -Ev "(\*|master|develop)" | xargs -n 1 git branch -d