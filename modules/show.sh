# Functions
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