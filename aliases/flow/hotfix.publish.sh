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
forceBranchUpdateFromOrigin "master";
tryRebase "master";
git push --force;
HOTFIX_NAME="$(getBranchNameWithoutPrefix)";
git pr create \
  --delete-source-branch \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch master \
  --title "Hotfix completed: $HOTFIX_NAME";
git pr create \
  --delete-source-branch \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Hotfix completed: $HOTFIX_NAME";
showSuccess "The hotfix branch was published";