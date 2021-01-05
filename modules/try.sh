# Imports
. "${AZ_GITFLOW_DIR}/modules/get.sh";
. "${AZ_GITFLOW_DIR}/modules/show.sh";

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

    git rev-parse --verify --quiet $BRANCH_TO_CREATE;
    local BRANCH_VERIFICATION_RESULT=$?;

    if [[ $BRANCH_VERIFICATION_RESULT -eq 0 ]];
    then
        showError "Branch '$BRANCH_TO_CREATE' already exists, it was not modified";
        exit 1;
    fi

    git rev-parse --verify --quiet origin/$BRANCH_TO_CREATE;
    local BRANCH_VERIFICATION_RESULT=$?;

    if [[ $BRANCH_VERIFICATION_RESULT -eq 0 ]];
    then
        showError "Branch '$BRANCH_TO_CREATE' already exists in origin, it was not modified";
        exit 1;
    fi

    git branch $BRANCH_TO_CREATE $BRANCH_TO_COPY;
    local BRANCH_CREATION_RESULT=$?;

    if [[ $BRANCH_CREATION_RESULT -ne 0 ]];
    then
        showError "Error creating '$BRANCH_TO_CREATE' branch, verify the status of your repository";
        exit 1;
    fi
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

function tryCheckout()
{
    local BRANCH_TO_CHECKOUT=$1;

    git checkout $BRANCH_TO_CHECKOUT;
    local CHECKOUT_RESULT=$?;

    if [[ $CHECKOUT_RESULT -ne 0 ]];
    then
        showError "Not able to checkout '$BRANCH_TO_CHECKOUT' branch. Close all applications that could be blocking files in your repository";
        exit 1;
    fi

    git add --intent-to-add .
    git diff --no-ext-diff --ignore-submodules --quiet --exit-code;
    local VERIFY_NONSTAGED_CHANGES=$?;
    if [[ $VERIFY_NONSTAGED_CHANGES -ne 0 ]];
    then
        git reset;
        showError "Not able to checkout '$BRANCH_TO_CHECKOUT' branch. Close all applications that could be blocking files in your repository";
        exit 1;
    fi
}

function tryFetch()
{
    git fetch origin;
    local FETCH_RESULT=$?;

    if [[ $FETCH_RESULT -ne 0 ]];
    then
        showError "Not able to fetch from origin, operation was stopped";
        exit 1;
    fi
}

function tryCreatePullRequest()
{
    local TARGET_BRANCH=$1;
    local TITLE=$2;
    local BROWSER_BEHAVIOR=$3;
    local REPOSITORY_NAME="$(getRepositoryName)";

    if [[ "$BROWSER_BEHAVIOR" = "OPEN BROWSER" ]];
    then
        git pr create \
            --delete-source-branch \
            --detect on \
            --open \
            --output table \
            --repository "$REPOSITORY_NAME" \
            --reviewers "CompIQ Team" \
            --target-branch "$TARGET_BRANCH" \
            --title "$TITLE";
        local PR_RESULT=$?;
    else
        git pr create \
            --delete-source-branch \
            --detect on \
            --output table \
            --repository "$REPOSITORY_NAME" \
            --reviewers "CompIQ Team" \
            --target-branch "$TARGET_BRANCH" \
            --title "$TITLE";
        local PR_RESULT=$?;
    fi

    if [[ $PR_RESULT -ne 0 ]];
    then
        showError "The creation of the Pull Request failed, verify your internet connection and token for VSTS-CLI.";
        exit 1;
    fi
}