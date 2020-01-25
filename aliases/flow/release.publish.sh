#!/bin/bash

# Imports
. $HOME/gitflow/modules/get.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchType "release";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
RELEASE_NAME="$(getBranchNameWithoutPrefix)";
git pr create \
  --delete-source-branch \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch master \
  --title "Next release: $RELEASE_NAME";
git pr create \
  --delete-source-branch \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Next release: $RELEASE_NAME";
git checkout develop;
showSuccess "The release branch was published";