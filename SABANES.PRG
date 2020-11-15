#Include "Inkey.ch"
#Include "Box.ch"
#Include "Setcurs.ch"

Set Scoreboard Off
Save Screen
SetColor("W+/BG,W+/R,BG,W+/B")
Cls
Telgr = SaveScreen(10,25,15,56)
SetColor("W+/RB")
@ 10,25,14,55 Box B_DOUBLE+CHR(32)
Sombra( 10,25,14,55,4,"GR+/N" )
@ 11,30 Say "Sabanes."
@ 12,27 Say "Programa para saber se"
@ 13,27 Say "repitiu de ano ou nao"
Inkey(4)
RestScreen( 10,25,15,56,Telgr )

While .T.
   SetColor("W+/G,N/W,,,W/N")
   @ 09,20,12,50 Box B_SINGLE_DOUBLE+CHR(32)
   Sombra( 09,20,12,50,4,"GR+/N" )
   Menur = 1
   @ 10,21 Prompt "Cadastrar pessoas            "
   @ 11,21 Prompt "Ver se repitiu               "
   Menu to Menur
   Do Case
      Case Menur=1
         Do Cadsa
      Case Menur=2
         Do Serep
      Otherwise
         SetColor("W/N,W/N,N,W/N")
         Cls
         Restore Screen
         Return Nil
   EndCase
End

***************
Procedure Cadsa
***************
Save Screen

   SetColor("W+/BG,W+/R,BG,W+/B")
   Cls
   If !File( "Sabcad.dbf" )
      SetColor("N/W")
      @ 03,38,05,73 Box B_SINGLE+CHR(32)
      @ 04,39 Say "Arquivo SABCAD.DBF n„o encontrado."
      Inkey(3)
      SetColor("W/N,W/N,N,W/N")
      Cls
      Restore Screen
      Return Nil
   Endif
      
   Use Sabcad.dbf New
   Index On D_NOME To Sabind
   
While .T.
   Set Key K_INS To Toins
   Set Key K_ALT_DEL To Delarq
   Nomme = Space(30)
   Iddad = 0
   Iddago = 00
   Seest = 00
   @ 00,00,24,79 Box B_SINGLE+CHR(32)
   @ 02,02 Say "Nome " Get Nomme Picture "@!" Valid chknome( Nomme )
   @ 04,02 Say "Idade em que come‡ou a escola " Get Iddad Picture "9"
   @ 06,02 Say "Idade que tem agora " Get Iddago Picture "99"
   @ 08,02 Say "S‚rie que est  " Get Seest Picture "99"
   Read
   If Lastkey()==K_ESC
      Close Databases
      Restore Screen
      Return Nil
   Endif
   Set Key K_INS To
   Set Key K_ALT_DEL To
   Wresp = " "
   @ 23,60 Say "Ok? " Get Wresp Picture "@!" Valid Wresp$"SN"
   Read
   If Wresp = "S"
      Replace D_NOME With Nomme
      Replace D_IDAD With Iddad
      Replace D_IDAGO With Iddago
      Replace D_SEEST With Seest
      Loop
   Endif
   If Wresp = "N"
      Loop
   Endif   
End

***************
Procedure Serep
***************
Save Screen
Set Key K_ALT_DEL To Delarq

While .T.
   SetColor( "W+/BG,W+/R,BG,W+/R" )
   nNome := Space( 30 )
   @ 00,00 Clear To 24,79
   If !File( "SABCAD.DBF" )
      SetColor("N/W")
      @ 03,38,05,73 Box B_SINGLE+CHR(32)
      @ 04,39 Say "Arquivo SABCAD.DBF n„o encontrado."
      Inkey(3)
      SetColor("W/N,W/N,N,W/N")
      Cls
      Restore Screen
      Return Nil
   Endif
   Use SABCAD.DBF New
   Index On D_NOME To Sabind
   @ 00,00,24,79 Box B_SINGLE+CHR(32)
   @ 01,01 Say "Nome " Get nNome Picture "@!" Valid Chkdn( nNome )
   Read
   Idago := D_IDAGO
   Idad  := D_IDAD
   nTotal := IDAGO -= IDAD
   If nTotal = D_SEEST
      @ 23,02 Say "Parab‚ns! Vocˆ nunca repitui de ano!"
      Inkey( 0 )
      @ 23,50 Say "Quer Voltar ou sair? "
      Inkey( 0 )
      If Chr(LastKey()) $ "Vv"
         Close DataBases
         Loop
      Else
         Exit
      Endif
   Endif
   If nTotal != D_SEEST
      @ 23,02 Say "H ! Que pena! Vocˆ j  repitiu de ano."
      Inkey( 0 )
      @ 23,50 Say "Quer Voltar ou sair? "
      Inkey( 0 )
      If Chr(LastKey()) $ "Vv"
         Close DataBases
         Loop
      Else
         Exit
      Endif
   Endif
End

Close DataBases
Restore Screen
Return Nil

   
********************************
Static Function chknome( cNome )
********************************
If !Dbseek( cNome )
   Append Blank
Else
   Save_Color = SetColor()
   SetColor( "W+/R" )
   @ 02,08 Say D_NOME Picture "@!"
   @ 04,33 Say D_IDAD Picture "9"
   @ 06,23 Say D_IDAGO Picture "99"
   @ 08,18 Say D_SEEST Picture "99"
   Nomme = D_NOME
   Iddad = D_IDAD
   Iddago = D_IDAGO
   Seest = D_SEEST
   SetColor( Save_Color )
Endif

Return .T.

******************************
Static Function Chkdn( cNome )
******************************
If !DbSeek( cNome )
   @ 23,00 Say "Pessoa n„o cadastrada!"
   Inkey( 0 )
   Return .F.
Else
   Return .T.
Endif
*********************
Static Function Toins
*********************
Set Key K_INS To
Readinsert(!Readinsert())
@ 23,02 Say If(Readinsert(), "<Insert>", "        ")
If Readinsert()
   SetCursor( SC_INSERT )
Endif
If !Readinsert()
   SetCursor( SC_NORMAL )
Endif
Set Key K_INS To Toins
Return Nil

**********************
Static Function Delarq
**********************
Set Key K_ALT_DEL To
Telvelh = SaveScreen(23,00,23,79)
Corvelh = SetColor()
Cdel = Space( 1 )
SetColor( "W+/BG,W+/R,BG,W+/R" )
While .T.
   SetColor("W+/R")
   @ 23,06 Say "Tem certeza de apagar? "
   @ 23,29 Get Cdel Picture "@!" Valid Cdel$ "SN"
   Read
   If Cdel = "S"
      Delete
      Pack
   Endif
   If Cdel = "N"
      Exit
   Endif
End
Set Key K_ALT_DEL To Delarq
RestScreen( 23,00,23,79,Telvelh )
Return Nil

*****************************************************************
STATIC FUNCTION Sombra( nL1, nC1, nL2, nC2, nTip_Sombra, cColor )
*****************************************************************

LOCAL nCor_Sombra

cColor := IIF( ISCOLOR(),"N+/N","W/N" )
nCor_Sombra = Cor_da_Sombra( cColor )

DO CASE
   CASE nTip_Sombra == 1 .AND. ( nL1 > 0 .AND. nC1 > 0 )
        Mostra_Sombra( nL1 - 1, nC1 - 1, nL1 - 1, nC2 - 1, nCor_Sombra )
        Mostra_Sombra( nL1 - 1, nC1 - 1, nL2 - 1, nC1 - 1, nCor_Sombra )

   CASE nTip_Sombra == 2 .AND. ( nL1 > 0 .AND. nC2 < MAXCOL() )
        Mostra_Sombra( nL1 - 1, nC1 + 1, nL1 - 1, nC2 + 1, nCor_Sombra )
        Mostra_Sombra( nL1 - 1, nC2 + 1, nL2 - 1, nC2 + 1, nCor_Sombra )

   CASE nTip_Sombra == 3 .AND. ( nL2 < MAXROW() .AND. nC1 > 0 )
        Mostra_Sombra( nL2 + 1, nC1 - 1, nL2 + 1, nC2 - 1, nCor_Sombra )
        Mostra_Sombra( nL1 + 1, nC1 - 1, nL2 + 1, nC1 - 1, nCor_Sombra )

   CASE nTip_Sombra == 4 .AND. ( nL2 < MAXROW() .AND. nC2 < MAXCOL() )
        Mostra_Sombra( nL2 + 1, nC1 + 1, nL2 + 1, nC2 + 1, nCor_Sombra )
        Mostra_Sombra( nL1 + 1, nC2 + 1, nL2 + 1, nC2 + 1, nCor_Sombra )
ENDCASE

RETURN NIL


****************************************************************
STATIC FUNCTION Mostra_Sombra( nL1, nC1, nL2, nC2, nNova_Sombra)
****************************************************************

LOCAL cArea_Velha, cArea_Nova, nCnt

cArea_Velha = SAVESCREEN( nL1, nC1, nL2, nC2 )
cArea_Nova = ""
FOR nCnt = 1 TO LEN(cArea_Velha) STEP 2
    cArea_Nova := cArea_Nova + SUBSTR(cArea_Velha, nCnt, 1) + CHR(nNova_Sombra)
NEXT
RESTSCREEN(nL1, nC1, nL2, nC2, cArea_Nova)
RETURN NIL


****************************************
STATIC FUNCTION  Cor_da_Sombra( cColor )
****************************************

LOCAL nPos, ;
      nForeground, ;
      nBackground, ;
      aTabColor

aTabColor := {  "N",  "B",  "G",  "BG",  "R",  "RB",  "GR",  "W", ;
                "N+", "B+", "G+", "BG+", "R+", "RB+", "GR+", "W+" }

cColor := ALLTRIM( UPPER(cColor) )
WHILE nPos # 0
   nPos := AT( " ", cColor )
   IF nPos != 0
      cColor := SUBS( cColor,1, nPos - 1 )+SUBS( cColor, nPos+1 )
   ENDIF
END
nPos := AT( "/", cColor )
DO CASE
   CASE nPos == 0
        nForeground := ASCAN( aTabColor, cColor )
        nForeground := IF( nForeground > 0, --nForeground, nForeground )
        nBackground := 0
   CASE nPos == 1
        nForeground := 0
        nBackground := ASCAN(  aTabColor, SUBS( cColor, 2 )  )
        nBackground := IF( nBackground > 0, --nBackground, nBackground )
   OTHERWISE
        nForeground := ASCAN(  aTabColor, SUBS( cColor, 1, nPos-1 )  )
        nForeground := IF( nForeground > 0, --nForeground, nForeground )
        nBackground := ASCAN(  aTabColor, SUBS( cColor, nPos+1 )  )
        nBackground := IF( nBackground > 0, --nBackground, nBackground )
ENDCASE

RETURN ( nBackground * 16 ) + nForeground
   
