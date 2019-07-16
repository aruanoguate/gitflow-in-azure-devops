ECHO ON
REM This should iterate over all the modules and execute
REM the init script on each one
FOR /f %%G in ('dir /b modules') DO (
    CALL "modules/%%G/init.bat"
)