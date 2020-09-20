#!/bin/bash

# Imports
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchNameIs "master";
verifyNoUncommitedChanges;

# To remove all branches already merged with the exception of master and develop
git fetch origin
git remote prune origin
git reset --hard origin/master
git checkout develop
git reset --hard origin/develop
git checkout master
git branch --merged | grep -v "\*" | grep -Ev "(\*|master|develop)" | xargs -n 1 git branch -d
showSuccess "The repository was cleaned";