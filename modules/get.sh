# Functions
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