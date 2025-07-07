#!/bin/bash

# Parameters 
BRANCH=$1;

# Imports
. "${AZ_GITFLOW_DIR}/modules/verify.sh"

# Validations
verifyInGitRepo;
verifyBranchNameProvided $BRANCH;

# Process
git flow.release.start $BRANCH;
git flow.release.publish;