ECHO OFF
FOR /f %%M IN ('dir /b modules') DO (
    FOR /f %%S IN ('dir /b modules\%%M\*.sh') DO (
        CALL :PROCESS_SHELL %%M %%S
    )
)
GOTO :eof

:PROCESS_SHELL
    SET aliasName=%1.%2
    SET aliasName=%aliasName:.sh=%
    SET filename='%CD%\modules\%1\%2'
    SET aliasCmd="!func() { sh %filename%; }; func"
    SET gitCmd=git config --global alias.%aliasName% %aliasCmd%
    %gitCmd%
EXIT /B