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
tryCreateBranch "release/$BRANCH" "develop";
tryCheckout "release/$BRANCH";
tryPushAndSetUpstream;
showSuccess "The new release branch was created";