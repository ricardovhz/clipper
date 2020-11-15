function copy3( copia, arqco, copa, arqcp )
   if !file( copia+"\"+arqco )
      ?? "Arquivo nao existente "+upper( copia )
      ?
      return nil
   endif
   if arqco = arqcp
      wresp := "N"
      ?? "Substituir "+upper( copa )+"\"+upper( arqcp )
      @ 24,79 get wresp picture "@!"
      read
      if wresp = "S"
         copy file ( copia )+"\"+( arqco ) to ( copa )+"\"+( arqcp )
         setpos( 24,79 )
         ? "1 arquivo(s) copiado(s)"
         ?
         return nil
      else
         ? "0 arquivos(s) copiados(s)"
         return nil
      endif
   endif
   copy file ( copia )+"\"+( arqco ) to ( copa )+"\"+( arqcp )
   ?? "1 arquivo(s) copiado(s)"
   ?
   return nil
   
