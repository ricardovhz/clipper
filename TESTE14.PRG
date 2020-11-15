borda1  := "…Õª∫ºÕ»∫ "
borda2  := "…Õª∫ºÕ»∫"
borda3  := "         "

save screen
setcolor("w+/b")
explod(11,40,11,40,0.025)
inkey(0)
setcolor("w+/r")
explod(11,40,11,40)
@ 00,24,02,44 box borda2
setcolor("w+/b")
@ 01,26 say "Verbatim italia90"
setcolor("w+/r")
@ 04,00,24,79 box borda1
htext := helptext("italia.hlp")
memoedit(htext,05,01,23,78,.f.)
setcolor("w/n")
implod( 00,00,00,79,25 )
@ 00,00 say "AtÇ a pr¢xima..."
setpos(23,00)
return nil

*****************
function helptext
*****************
parameters hfile
private hhandle, htbuf

hhandle := fopen(hfile)
if ferror() = 0
   htbuf := space(5200)
   fread( hhandle,@htbuf,5200 )
endif
fclose(hhandle)
return htbuf

***************************************
static function explod(li,ci,lf,cf,sec)
***************************************
if empty(sec)
   while li # 0
      @ li,ci,lf,cf box borda3
      li -= 1
      ci -= 4
      lf += 1
      cf += 4
   end
   @ 00,00,24,79 box borda3
else
   while li # 0
      inkey(sec)
      @ li,ci,lf,cf box borda3
      li -= 1
      ci -= 3
      lf += 1
      cf += 3
   end
   @ 00,00,24,79 box borda3
endif
return nil

**************************************
static function implod(li,ci,lf,cf,lc)
**************************************
biu := setcolor()
while li # lc
   setcolor("w/n")
   @ li,ci,lf,cf box borda3
   li += 1
end
setcolor( biu )
