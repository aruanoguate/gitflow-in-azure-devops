#!/bin/bash

# Parameters 
BRANCH=$1;

# Imports
. "${AZ_GITFLOW_DIR}/modules/force.sh"
. "${AZ_GITFLOW_DIR}/modules/show.sh"
. "${AZ_GITFLOW_DIR}/modules/try.sh"
. "${AZ_GITFLOW_DIR}/modules/verify.sh"

# Validations
verifyInGitRepo;
verifyBranchNameProvided $BRANCH;
verifyNoUncommitedChanges;

# Process
forceBranchUpdateFromOrigin "master";
tryCreateBranch "hotfix/$BRANCH" "master";
tryCheckout "hotfix/$BRANCH";
tryPushAndSetUpstream;
showSuccess "The new hotfix branch was created";