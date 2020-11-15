cls
setcolor("w+/n")
use arqed.dbf new
setcolor("n/w")
@ 00,00 say replicate( " ",79 )
lei := space( 12 )
@ 00,02 say "Digite o nome do arquivo." get lei picture "@K!S8"
read
setcolor("w+/n")
memoedit( meminho,01,00,24,132,.t. )
@ 00,60 say " "
setcolor("w/n")
cls
return nil
