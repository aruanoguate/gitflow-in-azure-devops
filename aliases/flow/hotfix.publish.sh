#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh

# Validations
verifyInGitRepo;
verifyBranchType "hotfix";
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
git checkout develop;
showSuccess "The hotfix branch was published";