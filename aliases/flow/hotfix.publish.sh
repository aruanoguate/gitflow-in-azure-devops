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
tryCreatePullRequest "master" "Hotfix completed: $HOTFIX_NAME" "OPEN BROWSER";
tryCreatePullRequest "develop" "Hotfix completed: $HOTFIX_NAME" "NO BROWSER";
showSuccess "The hotfix branch was published";