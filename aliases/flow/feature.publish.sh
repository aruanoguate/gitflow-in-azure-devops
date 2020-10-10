#!/bin/bash

# Imports
. $HOME/gitflow/modules/force.sh
. $HOME/gitflow/modules/get.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/try.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchTypeIs "feature";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
forceBranchUpdateFromOrigin "develop";
tryMerge "develop";
tryPush;
FEATURE_NAME="$(getBranchNameWithoutPrefix)";
tryCreatePullRequest "develop" "Feature completed: $FEATURE_NAME" "OPEN BROWSER";
showSuccess "The feature branch was published";