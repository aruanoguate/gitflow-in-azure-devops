#!/bin/bash

# Imports
. $HOME/gitflow/modules/get.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchTypeIs "release";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
RELEASE_NAME="$(getBranchNameWithoutPrefix)";
REPOSITORY_NAME="$(getRepositoryName)";
git pr create \
  --delete-source-branch \
  --detect on \
  --open \
  --output table \
  --repository $REPOSITORY_NAME \
  --reviewers "CompIQ Team" \
  --target-branch master \
  --title "Next release: $RELEASE_NAME";
git pr create \
  --delete-source-branch \
  --detect on \
  --output table \
  --repository $REPOSITORY_NAME \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Next release: $RELEASE_NAME";
showSuccess "The release branch was published";