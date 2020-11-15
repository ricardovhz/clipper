Public Lin
#include "inkey.ch"
#include "box.ch"
Set Scoreboard off

while .t.
   setcolor("w+/rb,w+/b,,,w+/rb")
   cls
   @ 00,00 Say Padc( "Programa que faz arquivo .DBF - Crid",78 )
   cNome := Space(60)
   cPic  := "@K!S8"
   Setcolor( "W+/R,W+/rb,,,W+/rb" )
   @ 10,23,14,52 Box B_DOUBLE+CHR(32)
   @ 11,26 Say "Digite o nome do .DBF"
   @ 12,33 Get cNome Picture cPic
   Read
   If Lastkey()==K_ESC
      Exit
   Endif
   If !File( Alltrim( cNome )+".DBF" )
      cCoiso := ""
   Else
      cCoiso := "Sim"
      Use ( Alltrim( cNome )+".DBF" ) Alias Cs New
   Endif
   Declare List_Typo[ 5 ]
   List_Typo[ 1 ] := "Character"
   List_Typo[ 2 ] := "Numeric  "
   List_Typo[ 3 ] := "Logical  "
   List_Typo[ 4 ] := "Date     "
   List_Typo[ 5 ] := "Memo     "
   Alterado  := .F.
   Setcolor("w+/rb")
   @ 00,00 Clear To 24,79
   Setcolor("w+/bg")
   @ 10,05,18,43 Box B_SINGLE_DOUBLE+CHR(32)
   @ 12,05 Say "ÇÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄ¶"
   @ 10,05 Say "ÖÄÄÄÄÄÄÒÄÄÄÄÄÄÄÄÄÄÄÒÄÄÄÄÄÄÄÄÒÄÄÄÄÄÄÄÄÄ·"
   @ 11,05 Say "º Name º    Type   º Lenght º Decimal º"
   For i = 13 To 17
      @ i,05 Say "º      º           º        º         º"
   Next
   @ 18,05 Say "ÓÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÄ½"
   If cCoiso = "Sim"
      Copy To Cbu Structure Extended
      Use Cbu Alias Dm New
//      Declare nNomes[ 
      Select Cs
      For I = 1 To 5
          @ I+12,14 Say List_Typo[ At( Field_Type, "CNLDM" ) ]+ " º   "+Str( Field_Len,2 )+"   º   "+Str( Field_dec,2 )
          Skip
      Next
   Else
      Create Cbu
      Use Cbu
      Lin := 13
   Endif
   While .T.
      cName := Space(20)
      cType := "C"
      cLeng := 10
      cDeci := 00
      Scol  := "@K!S6"
      Append Blank
      @ Lin,05 Say "º      º Character º   10   º         º"
      @ Lin,06 Get cName Picture Scol
      Read
      If Lastkey()==K_ESC
         If Alterado
            cResp := "S"
            @ 24,00 Say "Est  confirmado? " Get cResp Picture "Y" Valid !Empty( cResp )
            Read
            If cResp = "Y"
               Replace Field_Name With cName
               Replace Field_Type With cType 
               Replace Field_Len  With cLeng
               Replace Field_Dec  With cDeci
               Create ( Alltrim( cNome ) ) From Cbu
               Exit
            Else
               Exit
            Endif
         Else
            Exit
         Endif
      Endif
      Alterado := .T.
      Save_color := Setcolor()
      Setcolor("W+/B")
      @ Lin,14 Say "Character"
      Setcolor("W+/RB,W+/B")
      @ Lin,14 Get cType Picture "@!"
      Read
      Setcolor( Save_color )
      If Lastkey()==K_ESC
         If Alterado
            cResp := "Y"
            @ 24,00 Say "Est  confirmado? " Get cResp Picture "Y" Valid !Empty( cResp )
            Read
            If cResp = "Y"
               Replace Field_Name With cName
               Replace Field_Type With cType 
               Replace Field_Len  With cLeng
               Replace Field_Dec  With cDeci
               Create ( Alltrim( cNome ) ) From Cbu
               Exit
            Else
               Exit
            Endif
         Endif
      Endif
      nType := At( cType, "CNLDM" )
      @ Lin,14 Say List_Typo[ nType ]
      Do Case
         Case Upper( cType ) = "C"
            @ Lin,28 Get cLeng Picture "99"
            Read
            If Lastkey()==K_ESC
               If Alterado
                  cResp := "S"
                  @ 24,00 Say "Est  confirmado? " Get cResp Picture "Y" Valid !Empty( cResp )
                  Read
                  If cResp = "Y"
                     Replace Field_Name With cName
                     Replace Field_Type With cType 
                     Replace Field_Len  With cLeng
                     Replace Field_Dec  With cDeci
                     Create ( Alltrim( cNome ) ) From Cbu
                     Exit
                  Else
                     Exit
                  Endif
               Endif
            Endif
            Replace Field_name With cName
            Replace Field_type With cType
            Replace Field_len  With cLeng
            Replace Field_Dec With 0
            @ Lin,39 Say "0"
            Lin += 1
            If Lin > 17
               Lin := 17
               Scroll( 13,06,17,37,1 )
            Endif
         Case Upper( cType ) = "N"
            @ Lin,28 Get cLeng Picture "99"
            @ Lin,37 Get cDeci Picture "99"
            Read
            If Lastkey()==K_ESC
               If Alterado
                  cResp := "S"
                  @ 24,00 Say "Est  confirmado? " Get cResp Picture "Y" Valid !Empty( cResp )
                  Read
                  If cResp = "S"
                     Replace Field_Name With cName
                     Replace Field_Type With cType 
                     Replace Field_Len  With cLeng
                     Replace Field_Dec  With cDeci
                     Create ( Alltrim( cNome ) ) From Cbu
                     Exit
                  Else
                     Exit
                  Endif
               Endif
            Endif
            Replace Field_name With cName
            Replace Field_type With cType
            Replace Field_len  With cLeng
            Replace Field_dec  With cDeci
            Lin += 1
            If Lin > 17
               Lin := 17
               Scroll( 13,06,17,37,1 )
            Endif
         Case Upper( cType ) = "L"
            @ Lin,28 Say "  "
            Replace Field_name With cName
            Replace Field_type With cType
            Replace Field_len  With 1
            Replace Field_dec  With 0
            @ Lin,29 Say "1"
            Lin += 1
            If Lin > 17
               Lin := 17
               Scroll( 13,06,17,37,1 )
            Endif
         Case Upper( cType ) = "D"
            @ Lin,28 Say "  "
            Replace Field_name With cName
            Replace Field_type With cType
            Replace Field_len  With 8
            Replace Field_dec  With 0
            @ Lin,29 Say "8"
            @ Lin,39 Say "0"
            Lin += 1
            If Lin > 17
               Lin := 17
               Scroll( 13,06,17,37,1 )
            Endif
         Case Upper( cType ) = "M"
            Replace Field_name With cName
            Replace Field_type With cType
            Replace Field_len  With 10
            Replace Field_dec  With 0
            @ Lin,28 Say "10"
            @ Lin,39 Say "0"
            Lin += 1
            If Lin > 17
               Lin := 17
               Scroll( 13,06,17,37,1 )
            Endif
         Otherwise
            Loop
      Endcase
      Skip
      Loop
   End
   Setcolor("w+/rb")
   @ 24,00 Say "Deseja executar novamente?"
   Inkey(0)
   If Chr( Lastkey() ) $ "Ss"
      Close Databases
      Loop
   Endif
   If Chr( Lastkey() ) $ "Nn"
      Exit
   Endif
End 
Setcolor("w/n,w/n,n,w/n")
Cls
Return Nil
