#!/bin/bash

# Parameters 
BRANCH=$1;

# Imports
. $HOME/gitflow/modules/force.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/try.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchNameProvided $BRANCH;
verifyNoUncommitedChanges;

# Process
forceBranchUpdateFromOrigin "master";
tryCreateBranch "hotfix/$BRANCH" "master";
git checkout hotfix/$BRANCH;
tryPushAndSetUpstream;
showSuccess "The new hotfix branch was created";