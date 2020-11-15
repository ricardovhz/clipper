parameters wprog
save screen
if wprog = "HELP"
   return
endif
If wprog = "TESTE"
   @ 24,00 say "Eu sou o mais lindo do mundo!"
   inkey(0)
   restore screen
   return nil
endif
