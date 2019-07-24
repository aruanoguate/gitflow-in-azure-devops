function showError() {
    echo -e "\e[31mERROR: $1\e[0m";
}

function showWarning() {
    echo -e "\e[33mWARNING: $1\e[0m";
}

function updateDevelopBranch() {
    local BRANCH="$(getBranchName)"
    git fetch origin develop;
    git checkout develop;
    git reset --hard origin/develop;
    git checkout $BRANCH
}

function getBranchName() {
    local BRANCH=$(git rev-parse --abbrev-ref HEAD);
    echo "$BRANCH"
}

function verifyBranchType() {
    local BRANCHTYPE=$1;
    local BRANCH="$(getBranchName)"
    
    if [[ "$BRANCH" != "$BRANCHTYPE/"* ]]; then
        showError "This can only be executed on $BRANCHTYPE branches"
        exit 1
    fi
}

function verifyUpToDateBranch() {
    local BRANCH="$(getBranchName)"

    git fetch origin $BRANCH

    local LAST_LOCAL_COMMIT=$(git rev-parse HEAD)
    local LAST_UPSTREAM_COMMIT=$(git rev-parse @{u})
    
    if [[ "$LAST_LOCAL_COMMIT" != "$LAST_UPSTREAM_COMMIT" ]]; then
        showError "The branch should be up to date with its upstream"
        git status
        exit 1
    fi
}