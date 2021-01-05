#!/bin/bash

# Imports
. "${AZ_GITFLOW_DIR}/modules/show.sh"
. "${AZ_GITFLOW_DIR}/modules/verify.sh"

# Validations
verifyInGitRepo;
verifyNoUncommitedChanges;

# To remove all files and then re-add (this time following the gitignore rules)
git rm -r --cached .
git add .
git commit -m ".gitignore rules were forced on the repository"
showSuccess "A commit was created removing the ignored files";