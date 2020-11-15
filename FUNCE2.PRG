borda1 := chr(201)+chr(205)+chr(187)+chr(186)+chr(188)+chr(205)+chr(200)+chr(186)+" "

save screen
setcolor("w+/r,w/n,r,w/n")
cls
@ 00,00,24,79 box borda1
Vprint( 10,25,"O Ricardo" )
Vprint( 10,28,"E lindo" )
inkey(0)
setcolor("w/n,w/n,n,w/n")
cls
restore screen
return nil

************************************
Static Function Vprint( Li,Ci,Text )
************************************
Private I
For I = 1 To Len( Text )
   @ Li-1+I,Ci Say Subs( Text,I,1 )
Next
Return Nil
