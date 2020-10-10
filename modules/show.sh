# Functions
function showError()
{
    echo -e "\x1b[31mERROR: $1\x1b[0m";
}

function showWarning()
{
    echo -e "\x1b[33mWARNING: $1\x1b[0m";
}

function showSuccess()
{
    echo -e "\x1b[32mSUCCESS: $1\x1b[0m";
}