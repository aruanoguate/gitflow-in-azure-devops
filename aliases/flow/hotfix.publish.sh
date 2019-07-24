#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh

# Validations
verifyBranchType "hotfix";
verifyUpToDateBranch;

# Process
forceBranchUpdateFromOrigin "master";
tryRebase "master";
BRANCH="$(getBranchName)";
git push --force origin $BRANCH;
HOTFIX=${BRANCH/#"hotfix/"/""};
git pr create \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch master \
  --title "Hotfix completed: $HOTFIX";
git pr create \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Hotfix completed: $HOTFIX";
git checkout develop;
