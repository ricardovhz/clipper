@ECHO OFF
IF NOT EXIST SWPANDO.PTG GOTO ERRO
ARJ L SWPANDO.ARJ !LEI~RI.RIC > NUL
IF ERRORLEVEL 0 GOTO ERRO2
GOTO SAIR

:ERRO
ECHO Arquivo SWPANDO.PTG n�o est� contido.
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
ECHO               ����������������������������������������������Ŀ
ECHO               � Este programa � pirata. copia de um original �
ECHO               ������������������������������������������������
PAUSE > NUL

:SAIR
ECHO.
