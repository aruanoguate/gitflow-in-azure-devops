#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$BRANCH" != "feature/"* ]]; then
  echo -e "\e[31mERROR: This can only be executed on feature branches\e[0m"
  exit 1
fi

git fetch origin $BRANCH
LAST_LOCAL_COMMIT=$(git rev-parse HEAD)
LAST_UPSTREAM_COMMIT=$(git rev-parse @{u})
if [[ "$LAST_LOCAL_COMMIT" != "$LAST_UPSTREAM_COMMIT" ]]; then
  echo -e "\e[31mERROR: The branch should be up to date with its upstream\e[0m"
  git status
  exit 1
fi

git fetch origin develop
git checkout develop
git reset --hard origin/develop

git checkout $BRANCH
git rebase develop
git push --force origin $BRANCH

FEATURE=${BRANCH/#"feature/"/""}
git pr create \
  --delete-source-branch \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch develop \
  --title "Feature completed: $FEATURE"

git checkout develop
  