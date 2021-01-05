#!/bin/bash

# Imports
. "${AZ_GITFLOW_DIR}/modules/get.sh"
. "${AZ_GITFLOW_DIR}/modules/show.sh"
. "${AZ_GITFLOW_DIR}/modules/verify.sh"

# Validations
verifyInGitRepo;
verifyBranchTypeIs "release";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
RELEASE_NAME="$(getBranchNameWithoutPrefix)";
tryCreatePullRequest "master" "Next release: $RELEASE_NAME" "OPEN BROWSER";
tryCreatePullRequest "develop" "Next release: $RELEASE_NAME" "NO BROWSER";
showSuccess "The release branch was published";