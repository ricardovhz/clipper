#include "inkey.ch"
#include "box.ch"
#stdout Ricardo bonitao
set scoreboard off
setcolor("w+/n")
cls
setcolor("w+/r")
@ 05,20,07,69 box B_DOUBLE+CHR(32)

while .t.
   setcolor("w+/r")
   cpass := space(7)
   @ 06,22 say "Digite a senha. " get cpass
   read
   if lastkey()==K_ESC
      exit
   elseif cpass = "RICARDO" .or. cpass = "ricardo"
      setcolor("w+/n")
      @ 24,00 say "Senha Correta!"
      inkey(0)
      @ 24,00 say "              "
      exit
   else
      setcolor("w+/n")
      @ 24,00 say "Senha Errada!"
      inkey(0)
      @ 24,00 say "             "
      loop
   endif
end
setcolor("w/n,w/n,n,w/n")
cls
return nil
