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
forceBranchUpdateFromOrigin "master";
git branch hotfix/$BRANCH master;
git checkout hotfix/$BRANCH;
git push --set-upstream origin hotfix/$BRANCH;
showSuccess "The new hotfix branch was created";