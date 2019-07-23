#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$BRANCH" != "feature/"* ]]; then
  echo 'This can only be executed on feature branches';
  exit 1;
fi

git pull origin $BRANCH
git push origin $BRANCH
git fetch origin develop
git checkout develop
git reset --hard origin/develop
git checkout $BRANCH
git rebase develop
git push --force origin $BRANCH
FEATURE=${BRANCH/#"feature/"/""}
git pr create \
  --delete-source-branch \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Feature completed: $FEATURE"
git checkout develop
  