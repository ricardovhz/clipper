FUNCTION DR2( NFILE )
   CTELA := SAVESCREEN( ROW()-1,00,ROW()-1,79 )
   CCOLOR := COLORI( CTELA )
   SETCOLOR( CCOLOR )
   IF EMPTY( NFILE )
      ? "Desculpe. Mas tem que por o nome do arquivo. Se quer todos os arquivo, coloque *.*"
      ? "Cancelando..."
      ?
      QUIT
   ELSEIF !FILE( NFILE )
      ? "Arquivo n„o encontrado."
      ?
      QUIT
   ENDIF
   #INCLUDE "INKEY.CH"
   NARQS := DIRECTORY( NFILE, "D" )
   NCAMP2 := 1
   NCHUR := 0
   NBYE := NARQS[ NCAMP2 ][5]
   WHILE NBYE = "D"
      NCAMP2 += 1
      NCHUR += 1
      NBYE := NARQS[ NCAMP2 ][5]
   END
   NCAMP := 1
   NCONT := 1
   NCONTA := 0
   NCINTA := 0
   NBIU := 0
   NCOI := 23
   WHILE NCONT <= ADIR( NFILE )+NCHUR
      ? "   "+NAME( NARQS[ NCAMP ][1] )+" "+IIF( NARQS[ NCAMP ][5] = "D","<DIR>  ","       ")+STR( NARQS[ NCAMP ][2],06 )+"  Bytes  "+;
        DTOC( NARQS[ NCAMP ][3] )+"  "+NARQS[ NCAMP ][4]
      IF NCINTA = NCOI
         ? "Pressione qualquer tecla para continuar..."
         INKEY(0)
         NCINTA = 0
         NCOI = 24
      ENDIF
      NBIU += NARQS[ NCAMP ][2]
      NCAMP += 1
      NCONT += 1
      NCONTA += 1
      NCINTA += 1
   END
   ? "         "+STR( NCONTA,4 )+" "+IIF( NCONTA > 1,"Arquivos","Arquivo" )+"          "+STR( NBIU,6 )+" Bytes"
   ?
   QUIT

**********************
FUNCTION NAME( DNAME )
**********************
PRIVATE P, DRAT

DRAT := RAT( ".",DNAME )

IF DRAT = 0
   P := PED( DNAME,12 )
ELSE
   P := PED( SUBS( DNAME,1,DRAT-1 ), 9 )+SUBS( DNAME,DRAT+1 )
ENDIF

RETURN P

************************
FUNCTION PED( NOME, SP )
************************
RETURN SUBS( NOME+SPACE( SP ),1,SP )

*************************
FUNCTION COLORI( CTELA1 )
*************************
LOCAL PARCOR := SUBS( CTELA1,2,1 ), NARRAY := { "N","B","G","BG","R","RB","GR","W",;
                                                "N+","B+","G+","BG+","R+","RB+","GR+","W+" }
CBAI := ASC( PARCOR )
N2   := CBAI
// DESCOBRE A COR DO FUNDO
WHILE .T.
   IF CBAI < 16
      NFUNDO := 0
   ELSE
      NFUNDO := CBAI / 16
   ENDIF
   IF NFUNDO > 16
      LOOP
   ENDIF
   NFUNDO += 1
   EXIT
END
// DESCOBRE A COR DA LETRA
WHILE .T.
   IF N2 <= 16 .AND. NFUNDO = 1
      NTOTAL := N2
      NTOTAL += 1
   ELSE
      NTOTAL := N2 -= 16
      NTOTAL += 1
   ENDIF
   IF NTOTAL > 16
      LOOP
   ENDIF
   EXIT
END
NLET := NARRAY[ NTOTAL ]+"/"+NARRAY[ NFUNDO ]
RETURN NLET

