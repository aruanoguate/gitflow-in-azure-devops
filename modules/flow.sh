function showError() {
    echo -e "\e[31mERROR: $1\e[0m";
}

function showWarning() {
    echo -e "\e[33mWARNING: $1\e[0m";
}

function getBranchName() {
    local BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD);
    echo "$BRANCH_NAME";
}

function verifyBranchType() {
    local BRANCH_TYPE=$1;
    local BRANCH_NAME="$(getBranchName)";
    
    if [[ "$BRANCH_NAME" != "$BRANCH_TYPE/"* ]]; 
    then
        showError "This can only be executed on $BRANCH_TYPE branches";
        exit 1;
    fi
}

function verifyUpToDateBranch() {
    local BRANCH_NAME="$(getBranchName)";

    git fetch origin $BRANCH_NAME;

    local LAST_LOCAL_COMMIT=$(git rev-parse HEAD);
    local LAST_UPSTREAM_COMMIT=$(git rev-parse @{u});
    
    if [[ "$LAST_LOCAL_COMMIT" != "$LAST_UPSTREAM_COMMIT" ]]; 
    then
        showError "The branch $BRANCH_NAME should be up to date with its origin counterpart";
        git status;
        exit 1;
    fi
}

function verifyBranchNameProvided() {
    local BRANCH_NAME=$1;
    if [[ -z "$BRANCH_NAME" ]]; then
        showError "A name for the branch needs to be provided";
        exit 1;
    fi
}

function forceBranchUpdateFromOrigin() {
    local CURRENTBRANCH="$(getBranchName)";
    local BRANCHTOUPDATE=$1;
    git fetch origin $BRANCHTOUPDATE;
    git checkout $BRANCHTOUPDATE;
    git reset --hard origin/$BRANCHTOUPDATE;
    git checkout $CURRENTBRANCH;
}

function tryRebase() {
    local BRANCHTOREBASE=$1;
    git rebase $BRANCHTOREBASE;
    local REBASE_SUCCESS=$?;
    if [[ $REBASE_SUCCESS -ne 0 ]];
    then
        git rebase --abort;
        showError "Not able to automatically rebase '$BRANCHTOREBASE', rebase manually and then publish again";
        exit 1;
    fi
}