SAVE SCREEN
#include "inkey.ch"
setcolor("w+/g,w+/bg,g,w+/g")
cls
@ 01,01 say "Menu de inicializaao do MS-DOS 6.2"
@ 02,01 SAY "อออออออออออออออออออออออออออออออออออ"
@ 24,00 SAY "F5=Ignorar arq. iniciais F8=Confirmar cada linha CONFIG.SYS e AUTOEXEC.BAT"
NMENU = 1
@ 05,02 PROMPT "1. Humberto"
@ 06,02 PROMPT "2. Rodrigo"
@ 07,02 PROMPT "3. Ricardo"
@ 08,02 PROMPT "4. Rafael"
menu to nmenu
IF LASTKEY() == K_ESC
SETCOLOR("W/N,W/N,N")
RESTORE SCREEN
ENDIF

SETCOLOR("W/N,W/N,N")
RESTORE SCREEN
