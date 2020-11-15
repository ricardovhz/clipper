Public wfile, winde, field_b, field_m, menu_func, mc, mf, cf
#include "inkey.ch"
#include "achoice.ch"
deca := { "Field", "baias" }
setcolor("w+/n,n/w,,,w/n")
cls
@ 05,00 say padc( "Files",79 )
@ 09,00 say padc( "Indexes",79 )
@ 15,00 say padc( "Fields",79 )
declare Field_m[ 3 ]
declare Field_b[ 3 ]
Field_m[ 1 ] := "Files"
Field_m[ 2 ] := "Indexes"
Field_m[ 3 ] := "Fields"
Field_b[ 1 ] := "!Empty( wfile )"
Field_b[ 2 ] := "!Empty( winde )"
Field_b[ 3 ] := "!Empty( wfil )"
declare baias_m[ 3 ]
declare baias_b[ 3 ]
baias_m[ 1 ] = "Cala"
baias_m[ 2 ] = "Tua"
baias_m[ 3 ] = "Boca"
baias_b[ 1 ] = "!Empty( wfile )"
baias_b[ 2 ] = "!Empty( winde )"
baias_b[ 3 ] = "!Empty( wfil )"
wfile := space( 60 )
winde := space( 60 )
wfil  := ""
bfile := "@K!S8"
binde := "@K!S8"
@ 06,40 get wfile picture bfile
@ 10,40 get winde picture binde
read
Inkey(0)
Coiso()
cls
Return nil


***************
Function Coiso
***************
menu_sel := 0
menu_func := menu_key()
prev_func := 0
while menu_func > 0 .AND. menu_sel = 0
   if menu_func <> prev_func
      prev_func := menu_func
      a := deca[ menu_func ]
      ver_func()
      setcolor("n/w")
      @ 1, mc+1 say " "+deca[ menu_func ]+" "
      setcolor("w+/n,n/w,,,w/n")
      sav_screen := savescreen(2, mc, mf, cf)
      @ 2, mc to mf, cf
   endif
   menu_sel := achoice( 03,mc+1,mf-1,cf-1,&a._m, &a._b, "mu_func" )
   nkey := lastkey()
   do case
      case nkey == K_ESC
         menu_func := 0
      case nkey == K_RIGHT
          menu_func := if(menu_func < 2, menu_func + 1, 1)
      case nkey == K_LEFT
          menu_func := if(menu_func > 1, menu_func - 1, 2)
   endcase
   if menu_func <> prev_func .or. menu_sel <> 0
      setcolor("w+/n")
      @ 1, mc+1 say " "+deca[ prev_func ]+" "
      setcolor("w+/n,n/w,,,w/n")
      restscreen(2, mc, mf, cf, sav_screen )
   endif
end

return nil

****************
Function mu_func
****************
parameters amod
local nkey := lastkey()
if amod = AC_NOITEM
   inkey(0)
   r = AC_ABORT
else
   if nkey == K_ESC
      r = AC_ABORT
   else
      r = AC_CONT
   endif
endif
if amod = 3
   do case
      case nkey == K_ESC .or. nkey == K_LEFT .or. nkey == K_RIGHT
         r = AC_ABORT
      case nkey == K_ENTER
         r = AC_ABORT
   endcase
endif
return r

function menu_key
local nkey := lastkey()
private num
num := 0
do case
   case nkey == K_F1
      num := 1
   case nkey == K_F2
      num := 2
endcase
return num

function ver_func()
do case
   case menu_func = 1
        mc := 05
        mf := 06
        cf := 13
   case menu_func = 2
        mc := 15
        mf := 06
        cf := 23
endcase
return nil
