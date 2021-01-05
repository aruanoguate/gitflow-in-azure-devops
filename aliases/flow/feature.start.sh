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
forceBranchUpdateFromOrigin "develop";
tryCreateBranch "feature/$BRANCH" "develop";
tryCheckout "feature/$BRANCH";
tryPushAndSetUpstream;
showSuccess "The new feature branch was created";