#!/bin/bash

# Imports
. "${AZ_GITFLOW_DIR}/modules/force.sh"
. "${AZ_GITFLOW_DIR}/modules/get.sh"
. "${AZ_GITFLOW_DIR}/modules/show.sh"
. "${AZ_GITFLOW_DIR}/modules/try.sh"
. "${AZ_GITFLOW_DIR}/modules/verify.sh"

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