ierro := "*"
metime := { "CORINTHIANS           ","U. S. JOAO            ","PALMEIRAS            ",;
            "SAO PAULO             ","SANTOS                ","BRAGANCA             ",;
            "AMERICA               ","CATANDUBA             ","MARILIA              ",;
            "OLIMPIA               ","PORTUGUESA            ","BOTAFOGO             ",;
            "SAO CAETANO           ","RIO BRANCO            ",;
            }  
if !file( "CLUBES.DBF" )
   ierro := "s"
endif
if !file( "PARA.DBF" )
   ierro := "s"
endif
setcolor("W+/N")
cls
if empty( ierro )
   @ 13,35 to 15,64
   @ 14,36 say "Arquivo .DBF nao encontrado."   
   ? chr(7)
   inkey(0)
   setcolor("W/N")
   cls
   return nil
endif
//use CLUBES.DBF alias CB new
//use PARA.DBF alias PR new
if empty( PR->D_NOME )
   Append blank
   Nome := space(35)
   @ 00,10 say "Digite o seu nome...: " get Nome picture "@!"
   read
   @ 02,13 say "嬪様様冤様様様様様様冤様様冤様様様様様様�"
   @ 03,13 say "� [1] � Corinthians � [8] � Catanduba   �"
   @ 04,13 say "団陳陳田陳陳陳陳陳陳田陳陳田陳陳陳陳陳陳�"
   @ 05,13 say "� [2] � U. S. Joao  � [9] � Marilia     �"
   @ 06,13 say "団陳陳田陳陳陳陳陳陳田陳陳田陳陳陳陳陳陳�"
   @ 07,13 say "� [3] � Palmeiras   � [10]� Olimpia     �"
   @ 08,13 say "団陳陳田陳陳陳陳陳陳田陳陳田陳陳陳陳陳陳�"
   @ 09,13 say "� [4] � Sao Paulo   � [11]� Portuguesa  �"
   @ 10,13 say "団陳陳田陳陳陳陳陳陳田陳陳田陳陳陳陳陳陳�"
   @ 11,13 say "� [5] � Santos      � [12]� Botafogo    �"
   @ 12,13 say "団陳陳田陳陳陳陳陳陳田陳陳田陳陳陳陳陳陳�"
   @ 13,13 say "� [6] � Bragan�a    � [13]� Sao Caetano �"
   @ 14,13 say "団陳陳田陳陳陳陳陳陳田陳陳田陳陳陳陳陳陳�"
   @ 15,13 say "� [7] � Am�rica     � [14]� Rio Branco  �"
   @ 16,13 say "塒様様詫様様様様様様詫様様詫様様様様様様�"
   time = 1
   @ 03,14 prompt " [1] "
   @ 05,14 prompt " [2] "
   @ 07,14 prompt " [3] "
   @ 09,14 prompt " [4] "
   @ 11,14 prompt " [5] "
   @ 13,14 prompt " [6] "
   @ 15,14 prompt " [7] "
   @ 03,34 prompt " [8] "
   @ 05,34 prompt " [9] "
   @ 07,34 prompt " [10]"
   @ 09,34 prompt " [11]"
   @ 11,34 prompt " [12]"
   @ 13,34 prompt " [13]"
   @ 15,34 prompt " [14]"
   menu to time
   replace PR->D_TORC with metime[ time ]
   replace PR->D_NOME with Nome
endif
setcolor("w/n,w/n,n,w/n")
cls
return nil
