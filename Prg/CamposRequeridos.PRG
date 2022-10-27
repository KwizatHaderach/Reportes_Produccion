LOCAL _Campo1,  _Campo2, _Campo3, _Campo4, _Campo5, _Campo6, _Campo7

IF INLIST(VARTYPE(_DatosXML), "U", "L") THEN 
	RETURN .f.
ENDIF 

IF USED("IMPRESION") THEN 
	USE IN Impresion
ENDIF 

CREATE CURSOR Impresion (Campo1 c(15), Campo2 d(8), Campo3 n(10), Campo4 c(35), Campo5 n(10), Campo6 n(10,2), Campo7 c(3))

_ContadorProducto=0
DO WHILE .t.
	_ContadorProducto=_ContadorProducto+1
	
	_DatosProducto=STREXTRACT(_DatosXML, "<Producto>", "</Producto>", _ContadorProducto)
	
	IF EMPTY(ALLTRIM(_DatosProducto)) THEN 
		EXIT 
	ENDIF 
	
	_Campo1=ALLTRIM(STREXTRACT(_DatosXML, "<CodigoProducto>", "</CodigoProducto>"))		&&& Codigo de Producto
	_Campo2=CTOD(ALLTRIM(STREXTRACT(_DatosXML, "<Fecha>", "</Fecha>")))					&&& Fecha de Generacion de PRoducto
	_Campo3=VAL(STREXTRACT(_DatosXML, "<NumeroSerie>", "</NumeroSerie>"))				&&& Numero de Serie
	_Campo4=ALLTRIM(STREXTRACT(_DatosXML, "<DetalleProducto>", "</DetalleProducto>"))	&&& Detalle del Producto
	_Campo5=VAL(STREXTRACT(_DatosXML, "<Cantidad>", "</Cantidad>"))						&&& Cantidad de Producto
	_Campo6=VAL(STREXTRACT(_DatosXML, "<Peso>", "</Peso>"))							&&& Peso del Producto
	_Campo7=ALLTRIM(STREXTRACT(_DatosXML, "<UniMed>", "</UniMed>"))						&&& Unidad de Medida
	
	INSERT INTO Impresion VALUES (_Campo1,  _Campo2, _Campo3, _Campo4, _Campo5, _Campo6, _Campo7) 
ENDDO 
	
