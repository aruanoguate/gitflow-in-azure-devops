ECHO OFF
mkdir %userprofile%\gitflow\
xcopy /E /Y HELP.md %userprofile%\gitflow\
xcopy /E /Y modules %userprofile%\gitflow\modules\
xcopy /E /Y aliases %userprofile%\gitflow\aliases\
pushd %userprofile%\gitflow\
FOR /f %%A IN ('dir /b aliases') DO (
    FOR /f %%S IN ('dir /b aliases\%%A\*.sh') DO (
        CALL :PROCESS_ALIAS %%A %%S
    )
    FOR /f %%B IN ('dir /b aliases\%%A\*.bat') DO (
        CALL :PROCESS_BAT %%A %%B
    )
)
popd
GOTO :eof

:PROCESS_ALIAS
    SET aliasName=%1.%2
    SET aliasName=%aliasName:.sh=%
    SET filename='%CD%\aliases\%1\%2'
    SET aliasCmd="!func() { bash %filename% $@; }; func"
    SET gitCmd=git config --global alias.%aliasName% %aliasCmd%
    %gitCmd%
EXIT /B

:PROCESS_BAT
    SET filename="%CD%\aliases\%1\%2"
    CALL %filename%
EXIT /B