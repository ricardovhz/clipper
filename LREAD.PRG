function lread(nnome)
publi keystroke, menu_tec

while .t.
   setcolor("w+/b,w/n,b,w/n")
   cls
   @ 15,25 say pad(name(nnome),8)
   read_key()
   do case
      case menu_tec = 0
         setcolor("w/n,w/n,n,w/n")
         cls
         return nil
   endcase
end

FUNCTION name

PARAMETERS spec
PRIVATE p

* isolate filename and extension from path
p = SUBSTR(M->spec, RAT("\", M->spec) + 1)

IF "." $ M->p
	* there is an extension..chop it off
	p = SUBSTR(M->p, 1, AT(".", M->p) - 1)

ENDIF

RETURN M->p

function read_key
lkey = M->keystroke
keystroke = INKEY()
return (sysmenu() .or. M->keystroke <> 0)

FUNCTION sysmenu
local saveColor
PRIVATE menu_func,menu_sel,menu_buf,a,ml,mr,mb,prev_func,sav_row,sav_col,x

IF M->keystroke = 0
	* nothing happening
        MENU_TEC = 0
        RETURN .F.

ENDIF

* which menu?
menu_func = menu_key()

* always re-set this global selection variable
local_func = 0

IF M->menu_func = 0
	* no menu..regular keystroke
	RETURN .T.

ENDIF
menu_tec := menu_func

******
*	menu_key()
*
*	translate keystroke into menu number, zero if none
******
FUNCTION menu_key

PRIVATE num

* assume no menu request
num = 0

DO CASE

	CASE M->keystroke = 28
		* F1
		num = 1

	CASE M->keystroke < 0 .AND. M->keystroke > -8
		* F2 - F8 (ex. 1 - (-1) = 2)
		num = 1 - M->keystroke

	CASE M->keystroke >= 249 .AND. M->keystroke < 256
		* F2 - F8..function keys get truncated by the chr() function
		*	(ex. chr(-1) = chr(255)..257 - 255 = 2)
		num = 257 - M->keystroke

ENDCASE

RETURN M->num

************
function pad
************
parameters s, n

return subs(m->s + space(m->n), 1, m->n)
