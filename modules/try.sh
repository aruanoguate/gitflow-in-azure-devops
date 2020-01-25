# Imports
. $HOME/gitflow/modules/show.sh;

# Functions
function tryRebase()
{
    local BRANCH_TO_REBASE=$1;
    git rebase $BRANCH_TO_REBASE;
    local REBASE_RESULT=$?;
    if [[ $REBASE_RESULT -ne 0 ]];
    then
        git rebase --abort;
        showError "Not able to automatically rebase '$BRANCH_TO_REBASE', rebase manually and then publish again";
        exit 1;
    fi
}

function tryCreateBranch()
{
    local BRANCH_TO_CREATE=$1;
    local BRANCH_TO_COPY=$2;

    git rev-parse --verify $BRANCH_TO_CREATE;
    local BRANCH_VERIFICATION_RESULT=$?;

    if [[ $BRANCH_VERIFICATION_RESULT -ne 0 ]];
    then
        git branch $BRANCH_TO_CREATE $BRANCH_TO_COPY;
    else
        showWarning "Branch '$BRANCH_TO_CREATE' already exists, it was not modified";
    fi
}
