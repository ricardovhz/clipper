Public Nomarq, Nomedir, Keystroke
#include "Inkey.ch"
#include "Box.ch"
Borda1 := "ÉÍ»º¼ÍÊº "
Linha := space(8)
Set Scoreboard Off
Nomarq := ""

While .T.
   Setcolor("W+/B,W+/BG,B,W+/BG")
   explod(12,35,14,45,0.10)
   Cls
   @ 00,00 Say Padc( "Programa listador de arquivos texto feito no clipper - List3",79 )
   @ 24,00 Say Padc( "F10 - Run Dos  "+Chr(26)+"  Esc - Sa¡da", 79 )
   Setcolor( "W+/R,W+/BG,,,W+/BG" )
   @ 10,23,14,52 Box B_DOUBLE+CHR(32)
   @ 11,26 Say "Digite o nome do arquivo"
   @ 13,25 Say " Ok               Cancela "
   Alis  := 1

While .T.
   Coiso := 0
   Nomarq := Iif( Empty( Nomarq ), Ped( "", 60 ), Ped( Nomarq, 60 ) )
   Setcolor("W+/BG,,B")
   Setcursor( 0 )
   @ 12,33 Say Ped( Nomarq, 8 )
   Keystroke := Inkey(0)
   If Lastkey()==K_F10
      Run_Dos()
      Loop
   Endif
   If Lastkey()==K_ESC
      Setcolor("w/n,w/n,n,w/n")
      Cls
      Return Nil
   Endif
   Bai = Baicase()
   If Bai = 0
      Loop
   Endif
   If Bai = 2
      While .T.
         Coiso := 0
         Setcolor("W+/R,,B")
         @ 12,33 Say Ped( Nomarq, 8 )
         Ned := Escolha()
         If Ned = 0
            Loop
         Endif
         If Ned = 1
            If Empty( Nomarq )
               Coiso := 1
               Exit
            Else
               Coiso := 3
               Exit
            Endif
         Endif
         If Ned = 2
            Nomarq := Ped( "", 60 )
            Coiso := 1
            Exit
         Endif
         If Ned = 3
            Coiso := 1
            Exit
         Endif
         If Ned = 4
            Coiso = 4
            Exit
         Endif
      End
      If Coiso = 1
         Loop
      Endif
      If Coiso = 3
         Exit
      Endif
      If Coiso = 4
         Exit
      Endif
   Elseif Bai = 1
      Setcolor( "W+/R,W+/BG,,,W+/BG" )
      Set Key K_F10 To Clear_Gets
      Setcursor( 3 )
      Picx := "@K!S8"
      @ 12,33 Get Nomarq Picture Picx
      Read
      If Lastkey()==K_F10
         Run_Dos()
         Loop
      Endif
      If Lastkey()==K_ESC
         Clear Gets
         Loop
      Endif
      Set Key K_F10 To
      Setcolor("W+/R,,B")
      @ 12,33 Say Ped( Nomarq, 8 )
      Conarq := Iif( Empty( Nomarq ), "", Nomarq )
   Endif
   While .T.
      Coiso := 2
      Ned := Escolha()
      If Ned = 0
         Loop
      Endif
      If Ned = 1
         Exit
      Endif
      If Ned = 2
         Nomarq := Ped( "", 60 )
         Coiso := 1
         Exit
      Endif
      If Ned = 3
         Coiso := 1
         Exit
      Endif
      If Ned = 4
         Coiso := 4
         Exit
      Endif
   End
   If Coiso = 1
      Loop
   Endif
   If Coiso = 2
      Exit
   Endif
   If Coiso = 4
      Exit
   Endif
   If Coiso = 1
      Coiso := 0
      Loop
   Endif
   If Coiso = 2
      Exit
   Endif
   Setcolor( "W+/B,W+/BG,,,W+/BG" )
   If Lastkey()==K_ESC
      Setcolor("w/n,w/n,n,w/n")
      Cls
      Return Nil
   Endif
End

   && Executa a Lista‡ao

   If Coiso = 4
      Exit
   Endif
   If "*" $ Nomarq
      Setcolor("W+/B,,B")
      @ 00,00 Clear To 24,79
      @ 24,00 Say Padc( "Arquivo nao existente!",79 )
      Inkey(0)
      Loop
   Endif
   Setcolor("W+/B,,B")
   If !File( Nomarq )
      @ 00,00 Clear To 24,79
      @ 24,00 Say Padc( "Arquivo nao existente!",79 )
      Inkey(0)
      Loop
   Endif
   Set Key K_CTRL_P To Impre
   Set Key K_F10 To Run_Dos
   Nomedir := Directory( Nomarq, "D" )
   Ctexto := Textoesc( Nomarq )
   @ 00,00 Clear To 24,79
   Setcursor( 0 )
   Memoedit( Ctexto, 00,00,24,79,.F. )
   Set Key K_CTRL_P To
   Set Key K_F10 To
   Loop
End
Setcolor("W/N,W/N,N,W/N")
Cls
Return Nil

******************
Function Textoesc
******************
Parameters Escarq
Private Hhandle, Htbuf
hhandle := Fopen( Escarq )
Htbuf := Space( Nomedir[1][2] )
Fread( Hhandle, @Htbuf, Nomedir[1][2] )
Fclose( Hhandle )
Return Htbuf

***************
Function Impre
***************
Save Screen
Savecolor := Setcolor()
Setcolor( "W+/BG" )
@ 05,20,08,45 Box B_DOUBLE+CHR(32)
Sombra( 05,20,08,45,4,"GR+/N" )
@ 06,22 Say "Ligue A Impressora..."
Inkey(0)
If Lastkey()==K_ESC
   Restore Screen
   Setcolor( Savecolor )
   Return Nil
Endif
While !Isprinter()
   @ 07,22 Say "Impressora Desligada"
   Inkey(0)
   If Lastkey()==K_ESC
      Restore Screen
      Setcolor( Savecolor )
      Return Nil
   Endif
End
Set Device To Printer
Hhandle := Textoesc( Nomarq )
Nlinhas := Mlcount( Hhandle, 77 )
Li      := 0
For nCurrlin = 1 to Nlinhas
   cLinhas := Memoline( Hhandle, 77, nCurrlin )
   @ Li,00 Say cLinhas
   ++Li
Next
Set Device To Screen
Restore Screen
Setcolor( Savecolor )
Return Nil

************************
Function Ped( Text, Sp )
************************
Return Subs( Text+Space( Sp ),1,Sp )

*******************
Function Clear_Gets
*******************
Parameters Num1, Num2, Num3

Clear Gets
Return

******************
Function Run_Dos()
******************
Save_Color := Setcolor()
Save_Ins   := Setcursor()
Save_Screen := SaveScreen()
Setcolor("W/N,,N")
Setcursor( 1 )
@ 00,00 Clear To 24,79
?? 'Digite "EXIT"  para voltar ao programa.'
?
Run \Command 
Setcolor( Save_Color )
Cls
Restscreen( ,,,,Save_Screen )
Setcursor( Save_Ins )
Clear Typeahead
Return Nil

******************
Function Baicase()
******************
Ret := 0
Do Case
Case Keystroke > 41 .And. Keystroke < 123
   Keyboard Chr( Keystroke )
   Ret := 1
Case Keystroke = K_ENTER
   Ret := 1
Case Keystroke = K_DOWN
   Ret := 2
Endcase
Return Ret

**************************
static function escolha()
**************************
local twmen := { " Ok "," Cancela " }, ind := 1, cou := 25, nvalret := 1, Savs := Setcolor()
setcursor( 0 )

while .t.
   setcolor("w+/b")
   @ 13,cou say twmen[ ind ]
   inkey(0)
   If Lastkey()==K_F10
      Run_Dos()
   Endif
   if lastkey()==K_UP
      Nvalret := 3
      Exit
   endif
   if lastkey()==K_LEFT
      setcolor("w+/r")
      @ 13,cou say twmen[ ind ]
      cou := 25
      ind -= 1
      if ind = 0
         setcolor("w+/r")
         ind := 1
         @ 13,cou say twmen[ ind ]
         cou := 25
         ind := 1
         Nvalret := 1
         loop
      endif
      Nvalret := 1
      loop
   endif
   if lastkey()==K_RIGHT
      setcolor("w+/r")
      @ 13,cou say twmen[ ind ]
      cou := 42
      ind += 1
      if ind > 2
         ind := 2
         Nvalret := 0
         Exit
      endif
      Nvalret := 2
      loop
   endif
   If Lastkey()==K_ESC
      Nvalret := 4
      Exit
   Endif
   If Lastkey()==K_ENTER
      If Nvalret = 2
         setcolor("w+/r,n/w,,,n/w")
         @ 13,cou say twmen[ ind ]
         return nvalret
      elseif Nvalret = 1
         setcolor("w+/r,n/w,,,n/w")
         @ 13,cou say twmen[ ind ]
         return nvalret
      Endif
   Endif
End
Setcolor("W+/R")
@ 13,Cou Say Twmen[ Ind ]
Setcolor( Savs )
Return Nvalret

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

STATIC FUNCTION Explod( Li,Ci,Lf,Cf,Sec )

WHILE Li # 0
   @ Li,Ci,Lf,Cf BOX Linha
   INKEY( Sec )
   Li -= 1
   Ci -= 3
   Lf += 1
   Cf += 3
END
@ 00,00,24,79 BOX Linha

RETURN NIL

// da um efeito tipo "Implosao" para fechar tela

STATIC FUNCTION Implod( Li,Ci,Lf,Cf,Sec )

WHILE Li # 11
   Setcolor( "W/N" )
   @ 00,00,24,80 BOX Linha
   Setcolor( "W/R" )
   @ Li,Ci,Lf,Cf BOX Fundo
   INKEY( Sec )
   Li += 1
   Ci += 3
   Lf -= 1
   Cf -= 3
END
Setcolor( "W/N" )
@ 00,00,24,80 BOX Linha

RETURN NIL
