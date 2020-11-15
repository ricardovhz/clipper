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
   @ 02,13 say "ÕÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
   @ 03,13 say "³ [1] ³ Corinthians ³ [8] ³ Catanduba   ³"
   @ 04,13 say "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 05,13 say "³ [2] ³ U. S. Joao  ³ [9] ³ Marilia     ³"
   @ 06,13 say "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 07,13 say "³ [3] ³ Palmeiras   ³ [10]³ Olimpia     ³"
   @ 08,13 say "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 09,13 say "³ [4] ³ Sao Paulo   ³ [11]³ Portuguesa  ³"
   @ 10,13 say "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 11,13 say "³ [5] ³ Santos      ³ [12]³ Botafogo    ³"
   @ 12,13 say "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 13,13 say "³ [6] ³ Bragan‡a    ³ [13]³ Sao Caetano ³"
   @ 14,13 say "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 15,13 say "³ [7] ³ Am‚rica     ³ [14]³ Rio Branco  ³"
   @ 16,13 say "ÔÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
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
