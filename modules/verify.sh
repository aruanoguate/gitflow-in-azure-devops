# Imports
. "${AZ_GITFLOW_DIR}/modules/get.sh";
. "${AZ_GITFLOW_DIR}/modules/show.sh";
. "${AZ_GITFLOW_DIR}/modules/try.sh";

# Functions
function verifyInGitRepo()
{
    git rev-parse --git-dir >/dev/null 2>&1;
    local REPO_REVISION_RESULT=$?;

    if [[ $REPO_REVISION_RESULT -ne 0 ]]; 
    then
		showWarning "This can only be executed on a valid Git repository";
        exit 1;
	fi
}

function verifyBranchTypeIs()
{
    local BRANCH_TYPE=$1;
    local BRANCH_NAME="$(getBranchName)";
    
    if [[ "$BRANCH_NAME" != "$BRANCH_TYPE/"* ]]; 
    then
        showWarning "This can only be executed on '$BRANCH_TYPE' branches";
        exit 1;
    fi
}

function verifyBranchNameIs()
{
    local DESIRED_BRANCH=$1;
    local CURRENT_BRANCH="$(getBranchName)";
    
    if [[ "$CURRENT_BRANCH" != "$DESIRED_BRANCH" ]]; 
    then
        showWarning "This can only be executed on '$DESIRED_BRANCH' branch";
        exit 1;
    fi
}

function verifyUpToDateBranch()
{
    local BRANCH_NAME="$(getBranchName)";

    tryFetch;

    git rev-parse @{u}
    local VERIFY_UPSTREAM_BRANCH=$?;
    if [[ $VERIFY_UPSTREAM_BRANCH -ne 0 ]]; 
    then
        showWarning "The branch '$BRANCH_NAME' does not have an upstream branch in origin";
        exit 1;
    fi

    local LAST_LOCAL_COMMIT=$(git rev-parse HEAD);
    local LAST_UPSTREAM_COMMIT=$(git rev-parse @{u});
    
    if [[ "$LAST_LOCAL_COMMIT" != "$LAST_UPSTREAM_COMMIT" ]]; 
    then
        git status;
        showWarning "The branch '$BRANCH_NAME' should be up to date with its upstream branch in origin";
        exit 1;
    fi
}

function verifyBranchNameProvided()
{
    local BRANCH_NAME=$1;
    if [[ -z "$BRANCH_NAME" ]]; 
    then
        showWarning "A name for the branch needs to be provided";
        exit 1;
    fi
}

function verifyNoUncommitedChanges()
{
    git diff --no-ext-diff --ignore-submodules --quiet --exit-code;
    local VERIFY_NONSTAGED_CHANGES=$?;
    if [[ $VERIFY_NONSTAGED_CHANGES -ne 0 ]];
    then
        showWarning "Non-staged changes where found, stage and commit them before continue";
        exit 1;
    fi

    git diff --staged --no-ext-diff --ignore-submodules --quiet --exit-code;
    local VERIFY_STAGED_CHANGES=$?;
	if  [[ $VERIFY_STAGED_CHANGES -ne 0 ]]; 
    then
        showWarning "Staged changes where found, commit them before continue";
        exit 1;
	fi

    git add --intent-to-add .
    git diff --no-ext-diff --ignore-submodules --quiet --exit-code;
    local VERIFY_NONSTAGED_CHANGES=$?;
    if [[ $VERIFY_NONSTAGED_CHANGES -ne 0 ]];
    then
        git reset;
        showWarning "Non-tracked changes where found, stage and commit them before continue";
        exit 1;
    fi

}