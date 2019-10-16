#!/bin/bash

# Imports
. $HOME/gitflow/modules/flow.sh;

# Validations
verifyInGitRepo;
verifyNoUncommitedChanges;

# To remove all branches already merged with the exception of master and develop
git rm -r --cached .
git add .
git commit -m ".gitignore forced on repo"