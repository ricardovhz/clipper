#INCLUDE "INKEY.CH"
SETCOLOR("W+/B")
CLS
NCAMP := SPACE(10)
SET KEY K_F10 TO DOS
@ 13,20 GET NCAMP PICTURE "@!"
READ
SETCOLOR("W/N")
CLS
QUIT

************
FUNCTION DOS
************
SAVE SCREEN
SETCOLOR("W/N")
CLS
?? 'Digite "EXIT" para voltar ao dos'
?
RUN \COMMAND
RESTORE SCREEN
RETURN NIL
