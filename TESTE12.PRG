#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"
LINHA := "         "

SETCOLOR("W+/B")
CLS
@ 00,00,24,79 BOX B_DOUBLE
INKEY(0)
SETCOLOR("W+/R")
EXPLOD(10,38,11,40)
SETCOLOR("W+/B")
HELP_CODE := 1
HTEXT := HELPTEXT( "ITALIA.HLP",HELP_CODE )
@ 04,00,24,79 BOX B_DOUBLE
MEMOEDIT(HTEXT,05,01,23,78,.F.)
SETCOLOR("W/N")
EXPLOD(10,38,11,40,0.001)
@ 00,00 SAY "At‚ a pr¢xima"
SETPOS(23,00)
RETURN NIL

***************************************
STATIC FUNCTION EXPLOD(LI,CI,LF,CF)
***************************************
WHILE LI # 0
   @ LI,CI,LF,CF BOX LINHA
   LI -= 1
   CI -= 3
   LF += 1
   CF += 3
END
@ 00,00,24,79 BOX LINHA
RETURN NIL

FUNCTION helptext

PARAMETERS hfile, hnum
PRIVATE htbuf, hoff, hlen, hhandle

* open the file and get handle
hhandle = FOPEN(M->hfile)

IF FERROR() = 0
	* allocate 512 byte buffer
        htbuf = SPACE(5067)

	* read the file header into memory
        FREAD(M->hhandle, @htbuf, 5067)
ENDIF

* close the file and release the handle
FCLOSE(M->hhandle)
RETURN M->htbuf

