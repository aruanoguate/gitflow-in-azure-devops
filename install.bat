ECHO OFF

rmdir /S /Q %userprofile%\gitflow\
mkdir %userprofile%\gitflow\
xcopy /E /Y HELP.md %userprofile%\gitflow\
xcopy /E /Y config %userprofile%\gitflow\config\
xcopy /E /Y modules %userprofile%\gitflow\modules\
xcopy /E /Y aliases %userprofile%\gitflow\aliases\

pushd %userprofile%\gitflow\
copy NUL temp_install.bat
FOR /f %%A IN ('dir /b aliases') DO (
    FOR /f %%S IN ('dir /b aliases\%%A\*.sh') DO (
        CALL :PROCESS_ALIAS %%A %%S
    )
    FOR /f %%B IN ('dir /b aliases\%%A\*.bat') DO (
        CALL :PROCESS_BAT %%A %%B
    )
)
CALL temp_install.bat
popd

GOTO :eof

:PROCESS_ALIAS
    SET aliasName=alias.%1.%2
    SET aliasName=%aliasName:.sh=%

    SET gitCmd=git config --global --unset-all %aliasName%
    echo %gitCmd% >> temp_install.bat

    SET filename='%CD%\aliases\%1\%2'
    SET aliasCmd="!func() { bash %filename% $@; }; func"
    
    SET gitCmd=git config --global --replace-all %aliasName% %aliasCmd%
    echo %gitCmd% >> temp_install.bat
EXIT /B

:PROCESS_BAT
    SET filename="%CD%\aliases\%1\%2"
    echo. >> temp_install.bat
    type %filename% >> temp_install.bat
    echo. >> temp_install.bat
EXIT /B