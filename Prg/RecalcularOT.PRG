LPARAMETERS vpNumOTTra, vpProductoAsignado, vpCantidad, vpPeso
IF SEEK(vpNumOTTra, "ORDTRA",1) THEN  
	IF SEEK(STR(vpNumOTTra,10)+vpProductoAsignado, "DETORDTRA",4) THEN 
		IF DetOrdTra.TipUniMed=1 THEN 
			Replace Produccion WITH Produccion+vpCantidad IN DetORdTra
		ELSE
			Replace Produccion WITH Produccion+vpPeso IN DetORdTra
		ENDIF 
	ENDIF 
ENDIF 
_ResultadoProceso=Thisform.OrdenTrabajo1.CalcularPorcentajeAvanceOrdenTrabajo(Thisform.OTActiva)
IF STREXTRACT(_ResultadoProceso, "<Resultado>", "</Resultado>")!="true" THEN 
	=MESSAGEBOX(STREXTRACT(_ResultadoProceso, "<GlosaResultado>", "</GlosaResultado>"))
ENDIF 
