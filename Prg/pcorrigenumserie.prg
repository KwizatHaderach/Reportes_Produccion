CLOSE ALL
CLEAR ALL
stdVia="\\192.168.10.120\Ambientes\Copol\Datos\"
stdViaLocal="\\192.168.10.120\Ambientes\Copol\Data_Consultas\"


USE stdVia+"COPOL.DBF" IN 0 
USE stdVia+"NUMSERIE.DBF" IN 0 

_ContadorReemplazos=0
GO TOP IN NumSerie
DO WHILE !EOF("NUMSERIE") 
	WAIT WINDOW "Numero de serie en Proceso: "+ALLTRIM(NumSerie.NumSeri) NOWAIT 
	IF SEEK(NumSerie.NumSeri, "COPOL",1) THEN 
		IF !EMPTY(ALLTRIM(NumSerie.NumSeri)) THEN 
			IF EMPTY(NumSerie.FecSeri) THEN 
				Replace FecSeri WITH Copol.Fecha IN NumSerie
				_ContadorReemplazos=_ContadorReemplazos+1
			ENDIF 
			IF EMPTY(ALLTRIM(NumSerie.TipoIn)) THEN 
				IF !EMPTY(ALLTRIM(Copol.TipoReg)) THEN 
					Replace TipoIn WITH Copol.TipoReg IN NumSerie
					_ContadorReemplazos=_ContadorReemplazos+1
				ENDIF 
			ENDIF 
			IF EMPTY(ALLTRIM(NumSerie.Partida)) THEN 
				IF !EMPTY(ALLTRIM(Copol.NumReg)) THEN 
					Replace Partida WITH Copol.NumReg IN NumSerie
					_ContadorReemplazos=_ContadorReemplazos+1
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	
	SKIP IN NumSerie
ENDDO 
WAIT CLEAR 

=MESSAGEBOX("Se han Actualizado las fechas : "+ALLTRIM(STR(_ContadorReemplazos)))

CLOSE ALL
CLEAR ALL
