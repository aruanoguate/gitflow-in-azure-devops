#!/bin/bash

# Imports
. $HOME/gitflow/modules/force.sh
. $HOME/gitflow/modules/get.sh
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/try.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyBranchTypeIs "feature";
verifyNoUncommitedChanges;
verifyUpToDateBranch;

# Process
forceBranchUpdateFromOrigin "develop";
tryRebase "develop";
git push --force;
FEATURE_NAME="$(getBranchNameWithoutPrefix)";
REPOSITORY_NAME="$(getRepositoryName)";
git pr create \
  --delete-source-branch \
  --detect on \
  --open \
  --output table \
  --repository $REPOSITORY_NAME \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Feature completed: $FEATURE_NAME";
showSuccess "The feature branch was published";