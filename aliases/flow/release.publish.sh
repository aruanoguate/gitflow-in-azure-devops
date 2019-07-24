#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh

# Process
git checkout develop;
git pr create \
  --open \
  --output table \
  --reviewers "CompIQ Team" \
  --target-branch master \
  --title "Next Production Release";
  