#!/bin/bash

# Imports
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/try.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchNameIs "master";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
tryCreateBranch "develop" "master";
git checkout develop;
tryPushAndSetUpstream;
showSuccess "The repository was initialized";