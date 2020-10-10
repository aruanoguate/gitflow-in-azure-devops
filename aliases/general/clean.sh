#!/bin/bash

# Imports
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/try.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchNameIs "master";
verifyNoUncommitedChanges;

# To remove all branches already merged with the exception of master and develop
tryFetch;
git remote prune origin
git reset --hard origin/master
tryCheckout "develop";
git reset --hard origin/develop
tryCheckout "master";
git branch --merged | grep -v "\*" | grep -Ev "(\*|master|develop)" | xargs -n 1 git branch -d
showSuccess "The repository was cleaned";