#!/bin/bash

# Imports
. "${AZ_GITFLOW_DIR}/modules/force.sh"
. "${AZ_GITFLOW_DIR}/modules/get.sh"
. "${AZ_GITFLOW_DIR}/modules/show.sh"
. "${AZ_GITFLOW_DIR}/modules/try.sh"
. "${AZ_GITFLOW_DIR}/modules/verify.sh"

# Validations
verifyInGitRepo;
verifyBranchTypeIs "hotfix";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
HOTFIX_NAME="$(getBranchNameWithoutPrefix)";
tryCreatePullRequest "master" "Hotfix completed: $HOTFIX_NAME" "OPEN BROWSER";
tryCreatePullRequest "develop" "Hotfix completed: $HOTFIX_NAME" "NO BROWSER";
showSuccess "The hotfix branch was published";