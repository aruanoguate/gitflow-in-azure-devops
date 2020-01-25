#!/bin/bash

# Imports
. $HOME/gitflow/modules/show.sh
. $HOME/gitflow/modules/verify.sh

# Validations
verifyInGitRepo;
verifyNoUncommitedChanges;

# To remove all files and then re-add (this time following the gitignore rules)
git rm -r --cached .
git add .
git commit -m ".gitignore forced on repo"
showSuccess "A commit was created with the latest changes";