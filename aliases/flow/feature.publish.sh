#!/bin/bash

. $HOME/gitflow/modules/flow.sh

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$BRANCH" != "feature/"* ]]; then
  showError "This can only be executed on feature branches"
  exit 1
fi

git fetch origin $BRANCH
LAST_LOCAL_COMMIT=$(git rev-parse HEAD)
LAST_UPSTREAM_COMMIT=$(git rev-parse @{u})
if [[ "$LAST_LOCAL_COMMIT" != "$LAST_UPSTREAM_COMMIT" ]]; then
  showError "The branch should be up to date with its upstream"
  git status
  exit 1
fi

git fetch origin develop
git checkout develop
git reset --hard origin/develop

git checkout $BRANCH
git rebase develop
REBASE_SUCCESS=$?
if [[ $REBASE_SUCCESS -ne 0 ]];
then
    git rebase --abort
    showError "Not able to automatically rebase 'develop', rebase manually and then publish again"
    exit 1
fi

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
  