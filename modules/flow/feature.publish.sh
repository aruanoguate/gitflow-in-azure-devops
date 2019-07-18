#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$BRANCH" != "feature/"* ]]; then
  echo 'This can only be executed on feature branches';
  exit 1;
fi

git pull
git fetch origin develop
git checkout develop
git reset --hard origin/develop
git checkout $BRANCH
git rebase develop
git push --force origin $BRANCH
git pr create --target-branch develop --output table