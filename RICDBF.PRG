PUBLIC nColor,nTexto,Save_Color,nFields,nCoiso2,nSel,nRel,nArquivo,nLin,nElement,;
       nArq,nSim,nNao

Do Case
   Case IsColor()
      Declare nColor[10]
         nColor[1]  = "W/N,W/N,N"
         nColor[2]  = "BG+/N" 
         nColor[3]  = "G/N"
         nColor[4]  = "RB+/N"
         nColor[5]  = "W+/B"
         nColor[6]  = "W+/B,B/W,,,B/W"
         nColor[7]  = "W+/R"
         nColor[8]  = "W+/R,W+/R,,,W+/R"
         nColor[9]  = "G/N,N/GR,,,N/GR"
         nColor[10] = "N/GR"
Otherwise
      Declare nColor[10]
         nColor[1]  = "W/N,W/N,N"
         nColor[2]  = "W+/N"
         nColor[3]  = "N+/N"
         nColor[4]  = "W+/N"
         nColor[5]  = "N/W"
         nColor[6]  = "N/W,W/N,,,W/N"
         nColor[7]  = "N/W"
         nColor[8]  = "N/W,N/W,,,N/W"
         nColor[9]  = "W/N,N/W,,,N/W"
         nColor[10] = "N/W"
EndCase

#Include "Inkey.ch"
#Include "Box.ch"
#Include "SetCurs.ch"
#Include "Achoice.ch"

Set Cursor Off
Set Wrap On
Set ScoreBoard Off
Set Key K_ALT_C To AltC
Set Century On
Set Key K_F10 To RunDos

Declare nTexto[5]
   nTexto[1] = "Sistema para ler arq. DBF   Vers„o 1.01   Ind£stria RIC"
   nTexto[2] = "Teclas: F1 - Ajuda, Esc - Sa¡da, F10 - Executa Comandos do DOS"
   nTexto[3] = "Ir para o DOS? (S/N)"
   nTexto[4] = "Arquivo ->"
   nTexto[5] = "Field ->"

Save_Color = "W/N,W/N,N,,W/N"
nArq := ""
nSim := 0
nNao := 0

Save Screen
Cls
SetColor(nColor[1])
Clear
@ 00,00,02,79 Box B_DOUBLE_SINGLE+CHR(32)
@ 22,00,24,79 Box B_DOUBLE_SINGLE+CHR(32)
SetColor(nColor[2])
@ 01,01 Say PadC(nTexto[1],78)
SetColor(nColor[4])
Set Date To Italian
@ 23,01 Say PadL(Date(),78)
SetColor(nColor[2])
@ 23,01 Say nTexto[2]
nArquivo = ped("",100)
nCoiso2 := 0
While .T.
   SetColor(nColor[1])
   @ 05,00 Say nTexto[4]
   SetColor(nColor[10])
   Setcursor( SC_NONE )
   @ 05,11 Say Ped(nArquivo,8)
   Clear Typeahead
   Inkey(0)
   SetColor(nColor[4])
   @ 05,11 Say Ped(nArquivo,8)
   SetColor(nColor[1])
   If Lastkey()==K_ESC
      Do Sair
      Loop
   Endif
   Keystroke = Lastkey()
   Do Case
   Case Keystroke > 40 .And. Keystroke < 123
      Keyboard Chr( Keystroke )
      Ret := 0
   Case Keystroke = K_ENTER
      nRet := Dirs()
      If nRet = 1
         Ret := 1
      Else
         Ret := 0
      Endif
   Case Keystroke = K_DOWN
      If nCoiso2 = 1
         Setcolor( nColor[9] )
         nChoice = nAchoice( "Ricardo" )
         Loop
      Else
         Ret := 1
      Endif
   Case Keystroke = K_F10
      RunDos()
      Ret := 1
   Otherwise
      Ret := 1
   Endcase
   If Ret = 1
     Loop
   Endif
   SetColor( nColor[1] )
   Savetela := SaveScreen( 11,09,17,20 )
   @ 11,09 Clear To 17,20
   Setcolor( nColor[9] )
   nScroll = "@K!S8"
   SetCursor(SC_SPECIAL1)
   @ 05,11 Get nArquivo Picture nScroll
   Read
   If LastKey() == K_ESC
      Clear Gets
      RestScreen( 11,09,17,20,Savetela )
      Loop
   EndIf
   If LastKey() == K_F1
      Do Ajuda
   EndIf
   SetCursor(SC_NONE)
   If !File(Alltrim( nArquivo ))
      SetColor(nColor[4])
      @ 21,00 Say PadC("Arquivo "+Alltrim( nArquivo )+IIF( "." $ nArquivo,"",".DBF" )+" n„o encontrado.",79)
      Inkey(0)
      @ 21,00 Clear To 21,79
      Loop
   EndIf
   nArq := Alltrim(nArquivo)
   If "\" $ Alltrim(nArquivo)
      nPos := Rat("\",nArquivo)
      nArquivo := Ped(Subs(Alltrim(nArquivo),nPos+1),100)
   Endif
   SetColor(nColor[3])
   Use (nArq) New
   While .T.
      SetColor(nColor[4])
      @ 05,11 Say Ped(nArquivo,8)
      SetColor(nColor[1])
      @ 11,00 Say nTexto[5]
      Declare nFields[FCount()]
      AFields(nFields)
      SetColor(nColor[9])
      @ 11,09 Clear To 17,20
      nChoice = nAchoice()
      If nChoice != 0
         Loop
      Else
         nCoiso := 1
         Exit
      EndIf
      If LastKey() == K_ESC
         Do Sair
      EndIf
      If LastKey() == K_F1
         Do Ajuda1
      EndIf
      If LastKey() == K_F3
         Do Opcao
      EndIf
   End
   If nCoiso = 1
      Close Databases
      Loop
   Endif
End

PROCEDURE SAIR

While .T.
   SaveColor = SetColor()
   SetColor(nColor[7])
   @ 03,00 Say nTexto[3]
   Set Confirm Off
   nPerg = SPACE(1)
   SetColor(nColor[8])
   @ 03,20 Get nPerg Picture "@!"
   Read
   If LastKey() == K_ESC
      SetColor(nColor[1])
      @ 03,00 Clear To 03,79
      SetColor(SaveColor)
      Set Confirm On
      Exit
   EndIf
   If LastKey() == K_F1
      Do Ajuda2
   EndIf
   If nPerg = "S"
      SetColor(Save_Color)
      Cls
      Restore Screen
      Quit
   EndIf
   If nPerg = "N"
      SetColor(nColor[1])
      @ 03,00 Clear To 03,79
      SetColor(SaveColor)
      Set Confirm On
      Clear Typeahead
      Exit
   EndIf
   If nPerg != "S" .OR. "N"
      Loop
   EndIf
End
Return Nil

STATIC FUNCTION ALTC()
RETURN NIL

*********************************
Function Cagao( nResult,Sel,Rel )
*********************************
Local R := AC_CONT
nSel := Sel
nRel := Rel
Do Case
Case nResult = AC_HITTOP
   R := AC_ABORT
   nCoiso2 := 1
Case nResult = AC_EXCEPT
   If Lastkey()==K_ESC
      R := AC_ABORT
      nCoiso2 := 1
   Endif
   If Lastkey()==K_LEFT
      R := AC_CONT
   Endif
   If Lastkey()==K_RIGHT
      R := AC_CONT
   Endif
   If Lastkey()==K_HOME
      Keyboard Chr( 31 )
      R := AC_CONT
   Endif
   If Lastkey()==K_END
      Keyboard CHR( 30 )
      R := AC_CONT
   Endif
   If Lastkey()==K_ENTER
      R := AC_SELECT
   Endif
Otherwise
   R := AC_CONT
Endcase
Return R

***************************
Function nAchoice( nBordo )
***************************
If !Empty( nBordo )
   nChoice = AChoice(11,09,17,20,nFields,,"Cagao",nSel,nRel)
Else
   nChoice = AChoice(11,09,17,20,nFields,,"Cagao")
Endif
Return nChoice

************************
Function Ped( nText,Sp )
************************
Return Subs( nText+Space( Sp ),1,Sp )

***************
Function Dirs()
***************
nSim       := 0
nSaveTel   := SaveScreen(05,21,13,68)
nSaveColor := SetColor()
nSaveCurs  := SetCursor()
SetColor(nColor[5]+",B/BG")
SetCursor( 0 )
@ 05,21,13,68 Box B_DOUBLE_SINGLE+CHR(32)
@ 05,48 Say Chr(209)
For I = 1 To 7
   @ I+5,48 Say Chr(179)
Next
@ 13,48 Say Chr(207)
@ 06,22 Say "Ä Abrir o banco de dados Ä"
@ 06,49 Say "ÄÄÄÄÄÄ *.DBF ÄÄÄÄÄÄ"
@ 08,23 Say "Arquivo ->"
@ 11,23 Say " Ok             Cancela"
Declare nDir[ADir("*.DBF")]
ADir("*.DBF",nDir)
nLin := 07
nElement := 0
Wt := 0
nValor2 := 0
Tcharq := Ped("",200)
nScroll := "@K!S13"
SetPos(07,67)
While .T.
   If nValor2 = 0
      nChoice = AChoice(07,50,12,66,nDir,,"Chatao",nElement,nLin)
      If Lastkey() == K_ESC
         nValor2 := 0
         SetColor(nSaveColor)
         SetCursor(nSaveCurs)
         RestScreen( 05,21,13,68,nSaveTel )
         Ret := 1
         Exit
      Endif
      If nSim = 1
         nChoice := nElement
      Endif
   Endif
   If Lastkey() == K_LEFT .Or. nValor2 = 1
      Wt := 1
      nSai := 0
      If nSim = 1
         Tcharq := Alltrim( Tcharq )+nDir[ nChoice ]
      Endif
      While .T.
         SetColor("B/BG")
         SetCursor( 0 )
         @ 08,34 Say Ped(Tcharq,13)
         Keytroke := Inkey(0)
         Do Case
            Case Keytroke = K_F10
               RunDos()
               Nei := 1
            Case Keytroke = K_RIGHT
               SetColor( nColor[5] )
               @ 08,34 Say Ped(Tcharq,13)
               nLin := 08
               Fei := 0
               Exit
            Case Keytroke = K_DOWN
               SetColor(nColor[5])
               @ 08,34 Say Ped(Tcharq+Iif(".DBF" $ Tcharq,"",".DBF"),13 )
               Bei := Escolha()
               If Bei = 2
                  SetColor(nSaveColor)
                  SetCursor(nSaveCurs)
                  RestScreen( 05,21,13,68,nSaveTel )
                  Fei := 2
                  Exit
               Endif
               If !Empty(Tcharq) .And. Bei = 1
                  Keyboard Tcharq+Chr(K_ENTER)
                  nArquivo = Ped(Tcharq,100)
                  SetColor(nSaveColor)
                  SetCursor(nSaveCurs)
                  RestScreen( 05,21,13,68,nSaveTel )
                  Fei := 1
                  Exit
               Else
                  Wt := 30
                  Nei := 1
               Endif
            Case Keytroke = K_ESC
               SetColor(nSaveColor)
               SetCursor(nSaveCurs)
               RestScreen( 05,21,13,68,nSaveTel )
               Fei := 2
               Exit
            Case Keytroke > 40 .And. Keystroke < 123
               Keyboard Chr( Keytroke )
               Nei := 0
            Otherwise
               Nei := 1
         EndCase
         If Nei = 1
            Loop
         Endif
         SetColor(nColor[5]+",B/BG")
         SetCursor( 1 )
         @ 08,34 Get Tcharq Picture nScroll
         Read
         If Lastkey() == K_ESC
            Clear Gets
            Loop
         Endif
         If "\" $ Tcharq
            If !File( Alltrim( Tcharq )+"*.DBF" )
               SeveColor := Setcolor()
               SetColor(nColor[4])
               @ 21,00 Say PadC("Arquivo "+Alltrim( Tcharq )+"*.DBF"+" n„o encontrado.",79)
               Inkey(0)
               @ 21,00 Say PadC(" ",79)
               Setcolor( SeveColor )
               Tcharq := Ped( "",200 )
               Loop
            Endif
            Declare nDir[ Adir( Alltrim( Tcharq )+"*.DBF" ) ]
            Adir( Alltrim( Tcharq )+"*.DBF",nDir )
            SetColor( nColor[5] )
            @ 07,50 Clear To 12,66
            @ 08,34 Say Ped( Alltrim(Tcharq),13 )
            nSai := 1
            nNao := 1
            Exit
         Endif
         SetColor(nColor[5])
         @ 08,34 Say Ped(Alltrim(Tcharq)+Iif(".DBF" $ Tcharq,"",".DBF"),13)
         Tcharq := Ped(Alltrim(Tcharq)+Iif(".DBF" $ Tcharq,"",".DBF"),200)
         Bei := Escolha()
         If Bei = 1
            Keyboard Tcharq+Chr(K_ENTER)
            nArquivo = Ped(Tcharq,100)
            SetColor(nSaveColor)
            SetCursor(nSaveCurs)
            RestScreen( 05,21,13,68,nSaveTel )
            Fei := 1
            Exit
         Endif
         If Bei = 2
            SetColor(nSaveColor)
            SetCursor(nSaveCurs)
            RestScreen( 05,21,13,68,nSaveTel )
            Fei := 2
            Exit
         Endif
         If Bei = 3
            Loop
         Endif
         If Bei = 4
            nLin := 11
            Fei := 0
            Wt  := 30
            Exit
         Endif
      End
      If nSai = 1
         Loop
      Endif
   Else
      Tcharq := Ped(nDir[nChoice],100)
      @ 08,34 Say Ped(Tcharq,13)
      Bei := Escolha()
      If Bei = 1
         Keyboard Tcharq+Chr(K_ENTER)
         nArquivo = Ped(Tcharq,100)
         SetColor(nSaveColor)
         SetCursor(nSaveCurs)
         RestScreen( 05,21,13,68,nSaveTel )
         Ret := 0
         Exit
      Endif
      If Bei = 2
         SetColor(nSaveColor)
         SetCursor(nSaveCurs)
         RestScreen( 05,21,13,68,nSaveTel )
         Ret := 1
         Exit
      Endif
      If Bei = 3
         nValor2 := 1
         Loop
      Endif
      If Bei = 4
         nLin := 11
         Wt   := 30
         Loop
      Endif
   Endif
   If Fei = 0
      Loop
   Endif
   If Fei = 1
      Ret := 0
      Exit
   Endif
   If Fei = 2
      Ret := 1
      Exit
   Endif
End
Return Ret

***********************************
Function Chatao( nMode,nItem,nBin )
***********************************
Local nRetVal := AC_CONT,nKey := Lastkey()
nElement := nItem
nLin := nBin
Do Case
   Case nMode = AC_EXCEPT
     If nKey = K_ESC
        nRetVal := AC_ABORT
     Endif
     If nKey = K_LEFT
        nRetVal := AC_ABORT
     Endif
     If nKey = K_ENTER
        If nNao = 1
           nSim := 1
           Keyboard Chr( K_LEFT )+Chr( K_DOWN )
        Else
           nRetVal := AC_SELECT
        Endif
     Endif
EndCase
Return nRetVal

******************
Function Escolha()
******************
Local Nopcs := { " Ok "," Cancela " }, Ind := 1, nRetval := 1, nCol := 23
Saveins := SetCursor()
Savecolor := SetColor()
SetCursor( 0 )
While .T.
   SetColor("B/BG")
   @ 11,nCol Say nOpcs[ Ind ]
   Inkey(0)
   If Lastkey()==K_UP
      SetColor(nColor[5])
      @ 11,nCol Say nOpcs[ Ind ]
      nRetval := 3
      Exit
   Endif
   If Lastkey()==K_LEFT
      SetColor(nColor[5])
      @ 11,nCol Say nOpcs[ Ind ]
      Ind -= 1
      nCol := 23
      If Ind = 0
         Ind := 1
         nCol := 23
      Endif
   Endif
   If Lastkey()==K_RIGHT
      SetColor(nColor[5])
      @ 11,nCol Say nOpcs[ ind ]
      Ind += 1
      nCol := 38
      If Ind > 2
         nRetval := 4
         nLin := 11
         Keyboard Chr(K_RIGHT)
         Exit
      Endif
   Endif
   If Lastkey()==K_F10
      RunDos()
   Endif
   If Lastkey()==K_ESC
      nRetval := 3
      Keyboard Chr(K_ESC)
      Exit
   Endif
   If Lastkey()==K_ENTER
      SetColor(nColor[5])
      @ 11,nCol Say nOpcs[ Ind ]
      If Ind = 1
         nRetVal := 1
      ElseIf Ind = 2
         nRetval := 2
      Endif
      Exit
   Endif
End
SetColor( SaveColor )
SetCursor( Saveins )
Return nRetval
                 
***************
Function RunDos
***************
Save Screen To nSave
nBolor := SetColor()
nCurso := SetCursor()
SetColor("W/N,W/N,N,W/N")
SetCursor(1)
Cls
Run \Command
SetColor(nBolor)
SetCursor(nCurso)
Restore Screen From nSave
Return
Return
