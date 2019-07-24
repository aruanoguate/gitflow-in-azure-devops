function showError() {
    echo -e "\e[31mERROR: $1\e[0m";
}

function showWarning() {
    echo -e "\e[33mWARNING: $1\e[0m";
}

function updateDevelopBranch() {
    git fetch origin develop;
    git checkout develop;
    git reset --hard origin/develop;
}

