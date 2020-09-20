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
forceBranchUpdateFromOrigin "develop";
tryCreateBranch "feature/$BRANCH" "develop";
git checkout feature/$BRANCH;
tryPushAndSetUpstream;
showSuccess "The new feature branch was created";