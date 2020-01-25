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
git branch release/$BRANCH develop;
git checkout release/$BRANCH;
git push --set-upstream origin release/$BRANCH;
showSuccess "The new release branch was created";