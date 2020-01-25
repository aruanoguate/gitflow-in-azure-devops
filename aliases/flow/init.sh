#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh

# Validations
verifyInGitRepo;
verifyNoUncommitedChanges;
verifyCurrentBranch "master";
verifyUpToDateBranch;

# Process
tryCreateBranch "develop" "master";
git checkout develop;
git push --set-upstream origin develop;
showSuccess "The repository was initialized";