#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh

# Validations
verifyBranchType "feature";
verifyUpToDateBranch;

# Process
forceBranchUpdateFromOrigin "develop";
tryRebase "develop";
git push --force;
FEATURE_NAME="$(getBranchNameWithoutPrefix)";
git pr create \
  --delete-source-branch \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Feature completed: $FEATURE_NAME";
git checkout develop;
showSuccess "The feature branch was published";