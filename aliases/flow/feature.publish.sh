#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh

# Validations
verifyBranchType "feature";
verifyUpToDateBranch;

# Process
forceBranchUpdateFromOrigin "develop";
tryRebase "develop";
BRANCH="$(getBranchName)";
git push --force origin $BRANCH;
FEATURE=${BRANCH/#"feature/"/""};
git pr create \
  --delete-source-branch \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Feature completed: $FEATURE";
git checkout develop;
  