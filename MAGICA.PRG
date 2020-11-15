borda1 := chr(201)+chr(205)+chr(187)+chr(186)+chr(188)+chr(205)+chr(200)+chr(186)+" "
save screen

WHILE .T.
   set scoreboard off
   setcolor("w+/r,w/n,r,w+/n")
   cls
   @ 00,00,24,79 box borda1
   @ 19,26 say "ÄÄÄÄÄÄ"
   magic := "     "
   @ 13,19 say "Escreva cinco n£meros e vˆ o resultado antes.: "
   @ 14,27 get magic
   read
   if lastkey()==27
      setcolor("w/n,w/n,n,w/n")
      restore screen
      return nil
   endif   
   magic := val( magic ) + 199998
   @ 20,22 say magic
   setcolor("w/n,w/n,,,w/n")
   @ 15,27 say "     "
   num1 := " "
   num2 := " "
   num3 := " "
   num4 := " "
   num5 := " " 
   @ 15,27 get num1
   @ 15,28 get num2
   @ 15,29 get num3
   @ 15,30 get num4
   @ 15,31 get num5
   read
   if lastkey()==27
      setcolor("w/n,w/n,n,w/n")
      restore screen
      return nil
   endif   
   do case 
   case val( num1 ) =1
   @ 16,27 say "8"
   
   case val( num1 ) =2
   @ 16,27 say "7"
   
   case val( num1 ) =3
   @ 16,27 say "6"
   
   case val( num1 ) =4
   @ 16,27 say "5"
   
   case val( num1 ) =5
   @ 16,27 say "4"
   
   case val( num1 ) =6
   @ 16,27 say "3"
   
   case val( num1 ) =7
   @ 16,27 say "2"
   
   case val( num1 ) =8
   @ 16,27 say "1"
   
   case val( num1 ) =9
   @ 16,27 say "0"
   
   case val( num1 ) =0
   @ 16,27 say "9"
   endcase
   
   do case
   case val( num2 )=1
   @ 16,28 say "8"
   
   case val( num2 )=2
   @ 16,28 say "7"
   
   case val( num2 )=3
   @ 16,28 say "6"
   
   case val( num2 )=4
   @ 16,28 say "5"
   
   case val( num2 )=5
   @ 16,28 say "4"
   
   case val( num2 )=6
   @ 16,28 say "3"
   
   case val( num2 )=7
   @ 16,28 say "2"
   
   case val( num2 )=8
   @ 16,28 say "1"
   
   case val( num2 )=9
   @ 16,28 say "0"
   
   case val( num2 )=0
   @ 16,28 say "9"
   endcase
   
   do case
   case val( num3 )=1
   @ 16,29 say "8"
   
   case val( num3 )=2
   @ 16,29 say "7"
   
   case val( num3 )=3
   @ 16,29 say "6"
   
   case val( num3 )=4
   @ 16,29 say "5"
   
   case val( num3 )=5
   @ 16,29 say "4"
   
   case val( num3 )=6
   @ 16,29 say "3"
   
   case val( num3 )=7
   @ 16,29 say "2"
   
   case val( num3 )=8
   @ 16,29 say "1"
   
   case val( num3 )=9
   @ 16,29 say "0"
   
   case val( num3 )=0
   @ 16,29 say "9"
   endcase
   
   do case
   case val( num4 )=1
   @ 16,30 say "8"
   
   case val( num4 )=2
   @ 16,30 say "7"
   
   case val( num4 )=3
   @ 16,30 say "6"
   
   case val( num4 )=4
   @ 16,30 say "5"
   
   case val( num4 )=5
   @ 16,30 say "4"
   
   case val( num4 )=6
   @ 16,30 say "3"
   
   case val( num4 )=7
   @ 16,30 say "2"
   
   case val( num4 )=8
   @ 16,30 say "1"
   
   case val( num4 )=9
   @ 16,30 say "0"     
   case val( num4 )=0
   @ 16,30 say "9"
   endcase
   
   do case
   case val( num5 )==1
   @ 16,31 say "8"
   
   case val( num5 )==2
   @ 16,31 say "7"
   
   case val( num5 )==3
   @ 16,31 say "6"
   
   case val( num5 )==4
   @ 16,31 say "5"
   
   case val( num5 )==5
   @ 16,31 say "4"
   
   case val( num5 )==6
   @ 16,31 say "3"
   
   case val( num5 )==7
   @ 16,31 say "2"
   
   case val( num5 )==8
   @ 16,31 say "1"
   
   case val( num5 )==9
   @ 16,31 say "0"
   
   case val( num5 )==0
   @ 16,31 say "9"
endcase
   
   num6 := " "
   num7 := " " 
   num8 := " " 
   num9 := " " 
   numa := " " 
   @ 17,27 get num6
   @ 17,28 get num7
   @ 17,29 get num8
   @ 17,30 get num9
   @ 17,31 get numa
   read
   if lastkey()==27
   setcolor("w/n,w/n,n,w/n")
   restore screen
   return nil
   endif
   do case 
   case val( num6 )=1
   @ 18,27 say "8"
   
   case val( num6 )=2
   @ 18,27 say "7"
   
   case val( num6 )=3
   @ 18,27 say "6"     
   case val( num6 )=4
   @ 18,27 say "5"
   
   case val( num6 )=5
   @ 18,27 say "4"
   
   case val( num6 )=6
   @ 18,27 say "3"
   
   case val( num6 )=7
   @ 18,27 say "2"
   
   case val( num6 )=8
   @ 18,27 say "1"
   
   case val( num6 )=9
   @ 18,27 say "0"
   
   case val( num6 )=0
   @ 18,27 say "9"
endcase
                    
do case
   case val( num7 )=1
   @ 18,28 say "8"
   
   case val( num7 )=2
   @ 18,28 say "7"
   
   case val( num7 )=3
   @ 18,28 say "6"
   
   case val( num7 )=4
   @ 18,28 say "5"
   
   case val( num7 )=5
   @ 18,28 say "4"
   
   case val( num7 )=6
   @ 18,28 say "3"
   
   case val( num7 )=7
   @ 18,28 say "2"
   
   case val( num7 )=8
   @ 18,28 say "1"
   
   case val( num7 )=9
   @ 18,28 say "0"
   
   case val( num7 )=0
   @ 18,28 say "9"
endcase
   
do case
   case val( num8 )=1
   @ 18,29 say "8"
   
   case val( num8 )=2
   @ 18,29 say "7"
   
   case val( num8 )=3
   @ 18,29 say "6"
   
   case val( num8 )=4
   @ 18,29 say "5"
   
   case val( num8 )=5
   @ 18,29 say "4"
   
   case val( num8 )=6
   @ 18,29 say "3"
   
   case val( num8 )=7
   @ 18,29 say "2"
   
   case val( num8 )=8
   @ 18,29 say "1"
   
   case val( num8 )=9
   @ 18,29 say "0"
   
   case val( num8 )=0
   @ 18,29 say "9"
endcase
   
do case
   case val( num9 )=1
   @ 18,30 say "8"
   
   case val( num9 )=2
   @ 18,30 say "7"
   
   case val( num9 )=3
   @ 18,30 say "6"
   
   case val( num9 )=4
   @ 18,30 say "5"
   
   case val( num9 )=5
   @ 18,30 say "4"
   
   case val( num9 )=6
   @ 18,30 say "3"
   
   case val( num9 )=7
   @ 18,30 say "2"
   
   case val( num9 )=8
   @ 18,30 say "1"
   
   case val( num9 )=9
   @ 18,30 say "0"
   
   case val( num9 )=0
   @ 18,30 say "9"
endcase
   
do case
   case val( numa )=1
   @ 18,31 say "8"
   
   case val( numa )=2
   @ 18,31 say "7"
   
   case val( numa )=3
   @ 18,31 say "6"
   
   case val( numa )=4
   @ 18,31 say "5"
   
   case val( numa )=5
   @ 18,31 say "4"
   
   case val( numa )=6
   @ 18,31 say "3"
   
   case val( numa )=7
   @ 18,31 say "2"
   
   case val( numa )=8
   @ 18,31 say "1"
   
   case val( numa )=9
   @ 18,31 say "0"
   
   case val( numa )=0
   @ 18,31 say "9"
endcase
   
   setcolor("rb/r*")
   @ 14,60 say "Confira..."
   setcolor("rb/r,w+/n,,,w/n")
   per := space(1)
   @ 15,50 say "D  o mesmo resultado? " get per picture "@!" valid per$"SN"
   read
   if per = "S"
   @ 17,50 say "Deseja executar novente? "
   inkey(0)
   if chr(lastkey()) $ "Nn"
      exit
   endif
   endif
   if per = "N"
      @ 17,50 say "Vˆ de novo!"
      inkey(0)
      @ 18,50 say "D  o mesmo resultado? " get per picture "@!" valid per$"SN"
      read
      @ 19,50 say "Deseja executar novente? "
      inkey(0)
      if chr(lastkey()) $ "Nn"
         exit
      endif   
   endif
END

setcolor("w/n,w/n,n,w/n")
restore screen
