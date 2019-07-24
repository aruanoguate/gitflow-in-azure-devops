#!/bin/bash

. $HOME/gitflow/modules/flow.sh;

BRANCH=$1;
if [[ -z "$BRANCH" ]]; then
  showError "A name for the feature branch needs to be provided";
  exit 1;
fi

updateDevelopBranch;

git branch feature/$BRANCH develop;
git checkout feature/$BRANCH;
git push --set-upstream origin feature/$BRANCH;