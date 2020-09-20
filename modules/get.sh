# Functions
function getBranchName()
{
    local BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD);
    echo "$BRANCH_NAME";
}

function getBranchNameWithoutPrefix()
{
    local BRANCH_NAME_WITHOUT_PREFIX="$(getBranchName)";
    local BRANCH_NAME_WITHOUT_PREFIX="$(basename $BRANCH_NAME_WITHOUT_PREFIX)"
    echo "$BRANCH_NAME_WITHOUT_PREFIX";
}

function getRepositoryName()
{
    local REPOSITORY_NAME="$(git remote get-url origin)";
    local REPOSITORY_NAME="$(basename $REPOSITORY_NAME)"
    echo "$REPOSITORY_NAME";
}