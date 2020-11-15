@ECHO OFF
IF NOT EXIST SWPANDO.PTG GOTO ERRO
ARJ L SWPANDO.ARJ !LEI~RI.RIC > NUL
IF ERRORLEVEL 0 GOTO ERRO2
GOTO SAIR

:ERRO
ECHO Arquivo SWPANDO.PTG n„o est  contido.
GOTO SAIR

:ERRO2
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO               ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
ECHO               ³ Este programa ‚ pirata. copia de um original ³
ECHO               ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PAUSE > NUL

:SAIR
ECHO.
