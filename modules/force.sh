# Imports
. $HOME/gitflow/modules/get.sh;

# Functions
function forceBranchUpdateFromOrigin()
{
    local BRANCH_CURRENT="$(getBranchName)";
    local BRANCH_TO_UPDATE=$1;
    git fetch origin $BRANCH_TO_UPDATE;
    git checkout $BRANCH_TO_UPDATE;
    git reset --hard origin/$BRANCH_TO_UPDATE;
    git checkout $BRANCH_CURRENT;
}