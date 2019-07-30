#!/bin/bash

# Parameters 
BRANCH=$1;

# Imports
. $HOME/gitflow/modules/flow.sh;

# Validations
verifyBranchNameProvided $BRANCH;

# Process
forceBranchUpdateFromOrigin "master";
git branch hotfix/$BRANCH master;
git checkout hotfix/$BRANCH;
git push --set-upstream origin hotfix/$BRANCH;
showSuccess "The new hotfix branch was created";