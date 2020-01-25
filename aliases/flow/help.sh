#!/bin/bash

# Imports
. $HOME/gitflow/modules/show.sh

# Process
# cp $HOME/gitflow/config/md.nanorc /usr/share/nano/
nano -v -x -m $HOME/gitflow/HELP.md
showSuccess "The user manual was shown";