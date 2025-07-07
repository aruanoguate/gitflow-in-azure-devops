# Imports
. "${AZ_GITFLOW_DIR}/modules/get.sh";
. "${AZ_GITFLOW_DIR}/modules/try.sh";

# Functions
function forceBranchUpdateFromOrigin()
{
    local BRANCH_CURRENT="$(getBranchName)";
    local BRANCH_TO_UPDATE=$1;
    tryFetch;
    tryCheckout "$BRANCH_TO_UPDATE";
    git reset --hard origin/$BRANCH_TO_UPDATE;
    tryCheckout "$BRANCH_CURRENT";
}