function showError()
{
    echo -e "\e[31mERROR: $1\e[0m";
}

function showWarning()
{
    echo -e "\e[33mWARNING: $1\e[0m";
}

function showSuccess()
{
    echo -e "\e[32mSUCCESS: $1\e[0m";
}

function getBranchName()
{
    local BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD);
    echo "$BRANCH_NAME";
}

function getBranchNameWithoutPrefix()
{
    local BRANCH_NAME_WITHOUT_PREFIX="$(getBranchName)";
    local BRANCH_NAME_WITHOUT_PREFIX=${BRANCH_NAME_WITHOUT_PREFIX/#"feature/"/""};
    local BRANCH_NAME_WITHOUT_PREFIX=${BRANCH_NAME_WITHOUT_PREFIX/#"hotfix/"/""};
    local BRANCH_NAME_WITHOUT_PREFIX=${BRANCH_NAME_WITHOUT_PREFIX/#"release/"/""};
    echo "$BRANCH_NAME_WITHOUT_PREFIX";
}

function verifyInGitRepo()
{
    git rev-parse --git-dir >/dev/null 2>&1;
    local REPO_REVISION_RESULT=$?;

    if [[ $REPO_REVISION_RESULT -ne 0 ]]; 
    then
		showError "This can only be executed on a valid Git repository";
        exit 1;
	fi
}

function verifyBranchType()
{
    local BRANCH_TYPE=$1;
    local BRANCH_NAME="$(getBranchName)";
    
    if [[ "$BRANCH_NAME" != "$BRANCH_TYPE/"* ]]; 
    then
        showError "This can only be executed on $BRANCH_TYPE branches";
        exit 1;
    fi
}

function verifyUpToDateBranch()
{
    local BRANCH_NAME="$(getBranchName)";

    git fetch origin $BRANCH_NAME;

    local LAST_LOCAL_COMMIT=$(git rev-parse HEAD);
    local LAST_UPSTREAM_COMMIT=$(git rev-parse @{u});
    
    if [[ "$LAST_LOCAL_COMMIT" != "$LAST_UPSTREAM_COMMIT" ]]; 
    then
        git status;
        showError "The branch $BRANCH_NAME should be up to date with its origin counterpart";
        exit 1;
    fi
}

function verifyBranchNameProvided()
{
    local BRANCH_NAME=$1;
    if [[ -z "$BRANCH_NAME" ]]; 
    then
        showError "A name for the branch needs to be provided";
        exit 1;
    fi
}

function verifyNoUncommitedChanges()
{
    git diff --no-ext-diff --ignore-submodules --quiet --exit-code;
    local VERIFY_NONSTAGED_CHANGES=$?;
    if [[ $VERIFY_NONSTAGED_CHANGES -ne 0 ]];
    then
        showError "Non-staged changes where found, stage and commit them before continue";
        exit 1;
    fi

    git diff --staged --no-ext-diff --ignore-submodules --quiet --exit-code;
    local VERIFY_STAGED_CHANGES=$?;
	if  [[ $VERIFY_STAGED_CHANGES -ne 0 ]]; 
    then
        showError "Staged changes where found, commit them before continue";
        exit 1;
	fi
}

function forceBranchUpdateFromOrigin()
{
    local BRANCH_CURRENT="$(getBranchName)";
    local BRANCH_TO_UPDATE=$1;
    git fetch origin $BRANCH_TO_UPDATE;
    git checkout $BRANCH_TO_UPDATE;
    git reset --hard origin/$BRANCH_TO_UPDATE;
    git checkout $BRANCH_CURRENT;
}

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