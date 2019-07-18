#!/bin/bash

BRANCH=$1
if [[ -z "$BRANCH" ]]; then
  echo 'A name for the feature branch needs to be provided';
  exit 1;
fi

git fetch origin develop
git checkout develop
git reset --hard origin/develop
git branch feature/$BRANCH develop
git checkout feature/$BRANCH
git push --set-upstream origin feature/$BRANCH