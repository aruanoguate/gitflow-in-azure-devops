#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh;

# Validations
verifyInGitRepo;
verifyNoUncommitedChanges;

# To remove all files and then re-add (this time following the gitignore rules)
git rm -r --cached .
git add .
git commit -m ".gitignore forced on repo"