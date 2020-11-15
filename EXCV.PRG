save screen
setcolor("w+/r,w/n,r,w/n")
cls

while .t.
   esclen("Ricardo Vanhoz Ribeiro",10,32,"g/r")
   @ 24,00 say "Press any key..."
   keystroke := inkey(0)
   @ 24,00 say "                "
   if keystroke = 13
      esclen("Rodrigo Vanhoz Ribeiro",12,32,"b/r")
      @ 24,00 say "Press any key..."
      keystroke := inkey(0)
      if keystroke = 13
         esclen("Rafael Vanhoz Ribeiro",14,32,"b/r")
         @ 24,00 say "Press any key..."
         keystroke := inkey(0)
         loop
      else
         exit
      endif
   else
      exit
   endif
end
setcolor("w/n,w/n,n,w/n")
restore screen
return keyboard chr( keystroke )

****************
function esclen
****************
parameters ctext, li, ci, color
private savecolor, nct
savecolor := setcolor()
for nct = 1 to len(ctext)
   @ li, ci-1+nct say subs(ctext, nct,1)
   inkey(0.075)
next
setcolor( savecolor )
return nil
