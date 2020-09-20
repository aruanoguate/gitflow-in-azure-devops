#!/bin/bash

function PROCESS_ALIAS()
{
    local aliasName="alias.$(basename $1).$(basename $2)";
    local aliasName=${aliasName/".sh"/""}

    local gitCmd="git config --global --unset-all $aliasName"
    echo $gitCmd >> temp_install.bash

    local filename="$(pwd)/$2"
    local aliasCmd="!func() { bash $filename  \$@; }; func"
    
    local gitCmd="git config --global --replace-all $aliasName \"$aliasCmd\" "
    echo $gitCmd >> temp_install.bash
}

function PROCESS_BAT()
{
    local filename="$(pwd)/$2"
    echo "" >> temp_install.bash
    cat $filename >> temp_install.bash
    echo "" >> temp_install.bash
}

set +v
rm -Rf ~/gitflow/
mkdir ~/gitflow/
cp -f HELP.md ~/gitflow/
cp -Rf config ~/gitflow/config/
cp -Rf modules ~/gitflow/modules/
cp -Rf aliases ~/gitflow/aliases/

pushd ~/gitflow/
echo "#!/bin/bash" > temp_install.bash
for A in aliases/*; do
    if [ -d "${A}" ]; then
        for S in "${A}"/*.sh; do
            [ -e "$S" ] || continue
            PROCESS_ALIAS "${A}" "${S}";
        done
        for B in "${A}"/*.bat; do
            [ -e "$B" ] || continue
            PROCESS_BAT "${A}" "${B}";
        done
    fi
done
bash temp_install.bash
popd

