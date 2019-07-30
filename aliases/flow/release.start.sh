#!/bin/bash

# Parameters 
BRANCH=$1;

# Imports
. $HOME/gitflow/modules/flow.sh;

# Validations
verifyBranchNameProvided $BRANCH;

# Process
forceBranchUpdateFromOrigin "develop";
git branch release/$BRANCH develop;
git checkout release/$BRANCH;
git push --set-upstream origin release/$BRANCH;
showSuccess "The new release branch was created";