#INCLUDE "FILEIO.CH"
FUNCTION DEL2( DNOME, DREC )
   IF !FILE( "DJFRAIME.DBF" )
      AESTRU := { { "D_NOMEARQ","C",12,0 },;
                  { "D_MEMO","M",10,0 } }
      DBCREATE( "DJFRAIME.DBF",AESTRU )
   ENDIF
   USE DJFRAIME NEW
   INDEX ON D_NOMEARQ TO DJFRAIME
   IF "*" $ DNOME .AND. DREC = "/RE" .OR. DNOME = "/RE" .OR. "*" $ DNOME .AND. DREC = "/R"
      ? "DEL2 - A segunda versao do DEL. De Ricardo Vanhoz Ribeiro."
      SETCOLOR("W/N,W/N,,,W/N")
      GO TOP
      WHILE !EOF()
         DRESP := " "
         ?
         ? D_NOMEARQ+"  Recuperar? (S/N) "
         @ ROW(),COL() GET DRESP PICTURE "@!"
         READ
         IF UPPER( DRESP ) = "S"
            NOUTPUT := FCREATE( D_NOMEARQ, FC_NORMAL )
            FWRITE( NOUTPUT, D_MEMO )
            ?
            ?
            DELETE
            PACK
            ? "Arquivo recuperado com susseco!"
         ENDIF
         SKIP
      END
   ELSEIF !"*" $ DNOME .AND. DREC = "/R"
      ? "DEL2 - A segunda versao do DEL. De Ricardo Vanhoz Ribeiro."
      SETCOLOR("W/N,W/N,,,W/N")
      GO TOP
      IF !DBSEEK( DNOME )
         ?
         ? "Arquivo nao vai ser recuperado. Arquivo inexistente!"
         ?
         QUIT
      ENDIF
      DRESP := " "
      ?
      ? D_NOMEARQ+"  Recuperar? (S/N) "
      @ ROW(),COL() GET DRESP PICTURE "@!"
      READ
      IF UPPER( DRESP ) = "S"
         NOUTPUT := FCREATE( D_NOMEARQ, FC_NORMAL )
         FWRITE( NOUTPUT, D_MEMO )
         DELETE
         PACK
         ?
         ?
         ? "Arquivo recuperado com susseco!"
      ENDIF
   ELSEIF EMPTY( DREC )
      ? "DEL2 - A segunda versao do DEL. De Ricardo Vanhoz Ribeiro."
      ?
      IF DBSEEK( DNOME )
         DRESP := " "
         ? "Arquivo j  existente no nosso banco de arquivos. substitui-lo? "
         @ ROW(),COL() GET DRESP PICTURE "@!"
         READ
         IF UPPER( DRESP ) = "N"
            ?
            ?
            QUIT
         ENDIF
         IF UPPER( DRESP ) = "S"
            DELETE
            PACK
         ENDIF
      ENDIF
      APPEND BLANK
      NNOME := DNOME
      NDENTR := MEMOREAD( DNOME )
      REPLACE D_NOMEARQ WITH NNOME
      REPLACE D_MEMO WITH NDENTR
      ERASE (DNOME)
      ?
      ?
      QUIT
   ELSEIF "*" $ DNOME .AND. EMPTY( DREC )
      DECLARE DDIR[ ADIR( DNOME ) ]
      ADIR( DNOME, DDIR )
      IF DNOME = "*.*"
         IF !FILE( DNOME )
            ? "Arquivos n„o existentes!"
            QUIT
         ENDIF
         DRESP := " "
         ? "DEL2 - A segunda versao do DEL. De Ricardo Vanhoz Ribeiro."
         ?
         ? "Deletar todos os arquivos? (S/N) "
         @ ROW(),COL() GET DRESP PICTURE "@!"
         READ
         IF UPPER( DRESP ) = "S"
            NCONT := 1
            WHILE ADIR( DNOME ) >= NCONT
               NNOME := DDIR[ NCONT ]
               NDENTR := MEMOREAD( DDIR[ NCONT ] )
               REPLACE D_NOMEARQ WITH NNOME
               REPLACE D_MEMO WITH NDENTR
               ERASE (DNOME)
               NCONT += 1
            END
            ?
            ?
            QUIT
         ELSE
            ?
            ?
            QUIT
         ENDIF
      ENDIF
   ENDIF
