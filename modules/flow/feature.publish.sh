#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$BRANCH" != "feature/"* ]]; then
  echo 'This can only be executed on feature branches';
  exit 1;
fi

git fetch origin $BRANCH
LAST_LOCAL_COMMIT=$(git rev-parse HEAD)
LAST_UPSTREAM_COMMIT=$(git rev-parse @{u})
if [[ "$LAST_LOCAL_COMMIT" != "$LAST_REMOTE_COMMIT" ]]; then
  echo 'The branch should be up to date with its upstream';
  exit 1;
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
  