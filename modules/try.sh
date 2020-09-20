# Imports
. $HOME/gitflow/modules/get.sh;
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

function tryMerge()
{
    local BRANCH_TO_MERGE=$1;
    local BRANCH_DESTINATION="$(getBranchNameWithoutPrefix)";
    local MERGE_MESSAGE="Merge of '$BRANCH_TO_MERGE' into '$BRANCH_DESTINATION' performed by GitFlow Tool";

    git merge $BRANCH_TO_MERGE -m"$MERGE_MESSAGE";
    local MERGE_RESULT=$?;

    if [[ $MERGE_RESULT -ne 0 ]];
    then
        git merge --abort;
        showError "Not able to automatically merge '$BRANCH_TO_MERGE', merge manually and then publish again";
        exit 1;
    fi
}

function tryCreateBranch()
{
    local BRANCH_TO_CREATE=$1;
    local BRANCH_TO_COPY=$2;

    git rev-parse --verify $BRANCH_TO_CREATE;
    local BRANCH_VERIFICATION_RESULT=$?;

    if [[ $BRANCH_VERIFICATION_RESULT -eq 0 ]];
    then
        showWarning "Branch '$BRANCH_TO_CREATE' already exists, it was not modified";
        exit 1;
    fi

    git rev-parse --verify origin/$BRANCH_TO_CREATE;
    local BRANCH_VERIFICATION_RESULT=$?;

    if [[ $BRANCH_VERIFICATION_RESULT -eq 0 ]];
    then
        showError "Branch '$BRANCH_TO_CREATE' already exists in origin, the process was stopped";
        exit 1;
    fi

    git branch $BRANCH_TO_CREATE $BRANCH_TO_COPY;
}

function tryPush()
{
    git push;
    local PUSH_RESULT=$?;

    if [[ $PUSH_RESULT -ne 0 ]];
    then
        showError "Not able to push to origin, review the status of your branch";
        exit 1;
    fi
}

function tryPushAndSetUpstream()
{
    local BRANCH_TO_CREATE="$(getBranchName)";

    git push --set-upstream origin $BRANCH_TO_CREATE;
    local PUSH_RESULT=$?;

    if [[ $PUSH_RESULT -ne 0 ]];
    then
        showError "Not able to push '$BRANCH_TO_CREATE' to origin, review the status of your new branch";
        exit 1;
    fi
}