CLOSE ALL
CLEAR ALL

SET EXCLUSIVE OFF 

USE \\SERVERCOPOL\Reportes_Consulta\Data_Consultas\OrdTra SHARED IN 0
USE \\SERVERCOPOL\Reportes_Consulta\Data_Consultas\DetOrdTra SHARED IN 0
USE \\SERVERCOPOL\Reportes_Consulta\Data_Consultas\Copol_Sec SHARED IN 0
USE \\SERVERCOPOL\Sisgen\Datos\Copol SHARED IN 0


_ContadorRegistros=0
CALCULATE CNT() IN OrdTra TO _RegistrosTotales
GO TOP IN OrdTra
DO WHILE !EOF("ORDTRA")
	_ContadorRegistros=_ContadorRegistros+1
	
	Replace PorAva WITH CalculaPorcentajeAvanceOT(OrdTra.OT_ID) IN OrdTra
*!*		? "Orden de Trabajo N° "+ALLTRIM(STR(OrdTra.OT_ID))+", Porcentaje de Avance: "+ALLTRIM(STR(CalculaPorcentajeAvanceOT(OrdTra.OT_ID),15,2))+" %"
	WAIT WINDOW ALLTRIM(STR(ROUND((_ContadorRegistros*100)/_RegistrosTotales,2),10,2))+" %" NOWAIT 
	SKIP IN OrdTra
ENDDO 


CLOSE ALL
CLEAR ALL



FUNCTION CalculaPorcentajeAvanceOT
LPARAMETERS vpNumOrdTra
	_PorAvanceGBL	= 0
	_SumaAvance		= 0
	_ContadorItemOT	= 0

	SET ORDER TO 2 IN Copol_Sec
	SET ORDER TO 2 IN DetOrdTra

	IF SEEK(vpNumOrdTra, "DETORDTRA",2) THEN 
		DO WHILE !EOF("DETORDTRA") .and. DetOrdTra.OT_ID=vpNumOrdTra
			STORE 0 TO _CantidadProducida, _PesoProducido, _PorcentajeAvance
						
			IF SEEK(vpNumOrdTra,"COPOL_SEC",2) THEN 
				DO WHILE !EOF("COPOL_SEC") .and. Copol_Sec.OrdTra=vpNumOrdTra
					_NumeroSerie=PADR(ALLTRIM(STR(Copol_Sec.txt_Serie)),10, " ")
					IF SEEK(_NumeroSerie, "COPOL",1) THEN 
						IF Copol.txt_Produc=DetOrdTra.Codigo THEN 
								_CantidadProducida=_CantidadProducida+VAL(Copol.txt_Cantid)
								_PesoProducido=_PesoProducido+Copol.txt_Peso
						ENDIF 
					ENDIF 
					
					SKIP IN Copol_Sec
				ENDDO 
			ENDIF 
			
			IF DetOrdTra.TipUniMed=1 THEN 
				_PorcentajeAvance=((_CantidadProducida*100)/DetOrdTra.Cantidad)
			ELSE
				_PorcentajeAvance=((_PesoProducido*100)/DetOrdTra.Peso)
			ENDIF 
			
			_SumaAvance=(_SumaAvance+(_PorcentajeAvance/100))			
			_ContadorItemOT=_ContadorItemOT+1
			
			SKIP IN DetOrdTra
		ENDDO 

		_PorAvanceGBL=(_SumaAvance*100)/_ContadorItemOT		
	ENDIF 

	RETURN 	_PorAvanceGBL
ENDFUNC 

