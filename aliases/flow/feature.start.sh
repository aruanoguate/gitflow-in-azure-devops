#!/bin/bash

# Parameters 
BRANCH=$1;

# Imports
. $HOME/gitflow/modules/force.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchNameProvided $BRANCH;
verifyNoUncommitedChanges;

# Process
forceBranchUpdateFromOrigin "develop";
git branch feature/$BRANCH develop;
git checkout feature/$BRANCH;
git push --set-upstream origin feature/$BRANCH;
showSuccess "The new feature branch was created";