#include "inkey.ch"

#Define chfuf "SP,MG,MT,GO,TO,RS,SC,ES,RJ,AM,RO,RR,PR,MS,CE,SE,PB,RN,AL,AC,PI,MA,BA,PE,AP,PA,DF"
           
setcolor("w+/n")

while .T.
   cls
   ufi := space(2)
   @ 13,35 say "Digite o UF " get ufi ;
                              picture "@!" valid ufi $ chfuf
   read
end
setcolor("w/n")
cls
return nil


