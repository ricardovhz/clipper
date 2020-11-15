#include "inkey.ch"
borda1 := "ÖÄ·º½ÄÓº"
borda2 := "ÂÄ·º½ÄÁ³"
declare afiles[ adir( "*.DBF" ) ]
adir( "*.DBF", afiles )
setcolor("w+/b,n/w,b,n/w")
clear
@ 05,10,15,60 box borda1
@ 05,44,15,60 box borda2
@ 07,12 say "File "     
@ 14,12 say " Ok      Cancel"

while .t.
   setcolor("n/w")
   @ 07,17 say space(26)
   setcolor("w+/b")
   nChoice := achoice( 06,46,14,58,aFiles )
   if nChoice = 0
      setcolor("w/n,w/n,n,w/n")
      cls
      return nil
   endif
   setcolor("n/w")
   @ 07,17 say aFiles[ nChoice ]
   nesc := escolha()
   if nesc = 0
      loop
   endif
   setcolor("w/n,w/n,n,w/n")
   cls
   return nil
end
**************************
static function escolha()
**************************
local twmen := { " Ok "," Cancel " }, ind := 1, cou := 12, nvalret := 1
setcursor( 0 )

while .t.
   setcolor("w+/r")
   @ 14,cou say twmen[ ind ]
   inkey(0)
   if lastkey()==K_UP
      nvalret := 0
   endif
   if lastkey()==K_LEFT
      if ind = 1
         setcolor("w+/b")
         @ 14,cou say twmen[ ind ]
         cou := 20
         ind := 2
         loop
      endif
      setcolor("w+/b")
      @ 14,cou say twmen[ ind ]
      cou := 12
      ind := 1
      loop
   endif
   if lastkey()==K_RIGHT
      if ind = 2
         setcolor("w+/b")
         @ 14,cou say twmen[ ind ]
         cou := 12
         ind := 1
         loop
      endif
      setcolor("w+/b")
      @ 14,cou say twmen[ ind ]
      cou := 20
      ind := 2
      loop
   endif
   setcolor("w+/b,n/w,,,n/w")
   @ 14,cou say twmen[ ind ]
   return nvalret
end
