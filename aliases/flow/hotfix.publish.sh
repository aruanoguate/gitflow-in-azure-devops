#!/bin/bash

# Imports
. $HOME/gitflow/modules/force.sh
. $HOME/gitflow/modules/get.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/try.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchTypeIs "hotfix";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
HOTFIX_NAME="$(getBranchNameWithoutPrefix)";
REPOSITORY_NAME="$(getRepositoryName)";
git pr create \
  --delete-source-branch \
  --detect on \
  --open \
  --output table \
  --repository $REPOSITORY_NAME \
  --reviewers "CompIQ Team" \
  --target-branch master \
  --title "Hotfix completed: $HOTFIX_NAME";
git pr create \
  --delete-source-branch \
  --detect on \
  --output table \
  --repository $REPOSITORY_NAME \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Hotfix completed: $HOTFIX_NAME";
showSuccess "The hotfix branch was published";