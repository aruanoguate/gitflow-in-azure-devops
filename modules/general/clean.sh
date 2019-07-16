#!/bin/bash

# To remove all branches already merged with the exception of master and develop
git branch --merged | grep -v "\*" | grep -Ev "(\*|master|develop)" | xargs -n 1 git branch -d