SETCOLOR("W+/N,N/W,,,W/N")
CLS
NOPC := 1
@ 01,01 PROMPT "Ver com @K"
@ 02,01 PROMPT "Ver sem @K"
MENU TO NOPC
DO CASE
   CASE NOPC = 1
      DO CK
   CASE NOPC = 2
      DO SK
   OTHERWISE
      SETCOLOR("W/N,W/N,,,W/N")
      CLEAR SCREEN
      RETURN NIL
ENDCASE

************
PROCEDURE CK
************
CLEAR
CFILE := "Accounts"
@ 01,01 SAY "Enter file " GET CFILE PICTURE "@K"
READ
RETURN NIL

************
PROCEDURE SK
************
CLEAR
CFILE := "Accounts"
@ 01,01 SAY "Enter file " GET CFILE
READ
RETURN NIL

