SELECT txt_Serie as Serie, ALLTRIM(DTOC(Copol.Fecha)) as Fecha, txt_Produc as CodPro, ;
	   prDescrip as Detalle, prUniMed as UniMed, ;
	   IIF("KG" $ pruniMed, 00000000000001, VAL(txt_Cantid)) as Cantidad, ;
	   IIF(txt_Peso=0, IIF("KG" $ prUniMed, VAL(txt_Cantid), (VAL(txt_Cantid)*PesoKg)/1000),txt_Peso) as Peso, ;
	   SPACE(50) as Operador, ;
	   000000000000000.00 as CostoU, 000000000000000 as CosTot, ;
	   1 as Nivel, txt_Cod_se as CodMaq, txt_operad as CodOpe ;
	FROM Copol ;
	LEFT JOIN Producto ON prCodigo=txt_Produc ;
	LEFT JOIN UniProdu ON upCodigo=txt_Operad ;
	WHERE BETWEEN(Copol.Fecha,vfFechaInicial, vfFechaFinal) ;
	INTO CURSOR cDatosMaq READWRITE 
	
SELECT txt_Serie as Serie, ALLTRIM(DTOC(Copol.Fecha)) as Fecha, txt_cod_se as CodMaq, ;
	   txt_Produc as CodPro, prDescrip as Detalle, prUniMed as UniMed, ;
	   IIF("KG" $ pruniMed, 00000000000001, VAL(txt_Cantid)) as Cantidad, ;
	   IIF(txt_Peso=0, IIF("KG" $ prUniMed, VAL(txt_Cantid), (VAL(txt_Cantid)*PesoKg)/1000),txt_Peso) as Peso, ;
	   000000000000000.00 as CostoU, 000000000000000 as CosTot, ;
	   txt_Operad as Operador, 1 as Nivel ;
	FROM Copol ;
	LEFT JOIN Producto ON prCodigo=txt_Produc ;
	WHERE BETWEEN(Copol.Fecha,vfFechaInicial, vfFechaFinal) ;
	INTO CURSOR cDatosOper READWRITE 

SELECT txt_Serie as Serie, ALLTRIM(DTOC(Copol.Fecha)) as Fecha, txt_Operad as CodOpe, ;
	   SPACE(50) as DetOpe, prUniMed as UniMed, ;
	   IIF("KG" $ pruniMed, 000000000000001, VAL(txt_Cantid)) as Cantidad, ;
	   IIF(txt_Peso=0, IIF("KG" $ prUniMed, VAL(txt_Cantid), (VAL(txt_Cantid)*PesoKg)/1000),txt_Peso) as Peso, ;
	   txt_cod_se as CodMaq, SPACE(50) as DetMaq, ;
	   000000000000000 as CostoU, 000000000000000 as CosTot, ;
	   1 as Nivel, txt_Produc as CodPro ;
	FROM Copol ;
	LEFT JOIN Producto ON prCodigo=txt_Produc ;
	WHERE BETWEEN(Copol.Fecha,vfFechaInicial, vfFechaFinal) ;
	INTO CURSOR cDatosProd READWRITE