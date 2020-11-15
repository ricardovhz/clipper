#INCLUDE "INKEY.CH"
M_FRAME := "ÖÄ·º½ÄÓº"
HELPFILE := "TESTE8.HLP"
HELP_CODE := 1

CLS
SETCOLOR( "R/W" )
SCROLL( 10,25,20,54,0 )
@ 10,25,20,54 BOX M_FRAME
HTEXT := HELPTEXT( HELPFILE, HELP_CODE )
MEMOEDIT( HTEXT,11,26,19,53,.F.)
SETCOLOR( "W/N" )
CLS
RETURN NIL

FUNCTION helptext

PARAMETERS hfile, hnum
PRIVATE htbuf, hoff, hlen, hhandle

* open the file and get handle
hhandle = FOPEN(M->hfile)

IF FERROR() = 0
	* allocate 512 byte buffer
        htbuf = SPACE(195)

	* read the file header into memory
        FREAD(M->hhandle, @htbuf, 195)
ENDIF

* close the file and release the handle
FCLOSE(M->hhandle)
RETURN M->htbuf

