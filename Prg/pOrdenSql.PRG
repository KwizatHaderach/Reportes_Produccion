CLOSE ALL
CLEAR ALL

SET DELETED ON


USE \\SERVERCOPOL\sisgen\datos\copol.DBF  IN 0
USE \\SERVERCOPOL\sisgen\datos\Producto.DBF  IN 0
USE \\SERVERCOPOL\sisgen\datos\UniProdu.DBF  IN 0

PUBLIC ARRAY aSumMes(12)

aSumMes(1)=.t.
aSumMes(2)=.t.
aSumMes(3)=.t.
aSumMes(4)=.t.
aSumMes(5)=.t.
aSumMes(6)=.t.
aSumMes(7)=.t.
aSumMes(8)=.t.
aSumMes(9)=.t.
aSumMes(10)=.t.
aSumMes(11)=.t.
aSumMes(12)=.t.

IF USED("cVISUALPERIODO") THEN 
	USE IN cVisualPeriodo
ENDIF 

CREATE CURSOR cVisualPeriodo (Codigo c(25), Detalle c(50), ;
							  Peso1 n(15), Can1 n(15), Cos1 n(15), ;
							  Peso2 n(15), Can2 n(15), Cos2 n(15), ;
							  Peso3 n(15), Can3 n(15), Cos3 n(15), ;
							  Peso4 n(15), Can4 n(15), Cos4 n(15), ;
							  Peso5 n(15), Can5 n(15), Cos5 n(15), ;
							  Peso6 n(15), Can6 n(15), Cos6 n(15), ;
							  Peso7 n(15), Can7 n(15), Cos7 n(15), ;
							  Peso8 n(15), Can8 n(15), Cos8 n(15), ;
							  Peso9 n(15), Can9 n(15), Cos9 n(15), ;
							  Peso10 n(15), Can10 n(15), Cos10 n(15), ;
							  Peso11 n(15), Can11 n(15), Cos11 n(15), ;
							  Peso12 n(15), Can12 n(15), Cos12 n(15), ;
							  PesoTot n(15), CanTot n(15), CosTot n(15), ;
							  CodPro c(15), CodOpe c(4), Nivel c(1), DetOpe c(35))

INDEX on CodOpe+CodPro TAG Enlace001

vGestion=2015

SELECT SPACE(4)+txt_Produc as Codigo, SPACE(8)+NVL(prDescrip, "(Desconocido)") as Detalle, ;
	   SUM(IIF(prUniMed="KG",VAL(txt_Cantid),0)) as Peso, ;
	   SUM(IIF(prUniMed!="KG",VAL(txt_Cantid),0)) as Cantidad, ;
	   0000000000000000 as Costo, ;
	   txt_Operad as Operador,  txt_Produc as CodPro, ;
	   SPACE(35) as DetOpe, Copol.Fecha as Fecha, prUnimed as Unidad ;
	FROM Copol  ;
	LEFT JOIN Producto ON prCodigo=txt_Produc ;
	WHERE !EMPTY(ALLTRIM(txt_Operad)) .or. ;
		  !EMPTY(ALLTRIM(txt_Produc)) .and. ;
		   YEAR(Copol.Fecha)=vGestion ;
	GROUP BY txt_Operad, txt_Produc ;
	INTO CURSOR cResumenProd READWRITE 

UPDATE cResumenProd ;
	FROM UniProdu ;
	SET DetOpe=upNombre ;
	WHERE Operador=upCodigo
	
UPDATE cResumenProd ;
	FROM Producto ;
	SET Peso=Cantidad*(PesoKg/1000) ;
	WHERE CodPro=prCodigo

UPDATE cResumenProd ;
	FROM Producto ;
	SET Costo=IIF(Unidad!="KG",Cantidad*CostoVen,Peso*Costoven) ;
	WHERE CodPro=prCodigo
	
GO TOP IN cResumenProd
DO WHILE !EOF("cRESUMENPROD")
	IF SEEK(cResumenProd.Operador+cResumenProd.CodPro, "cVISUALPERIODO",1) THEN 
		DO CASE 
			CASE MONTH(cResumenProd.Fecha)=1
				Replace Peso1 WITH Peso1+cResumenProd.Peso, ;
						Can1 WITH Can1+cResumenProd.Cantidad, ;
						Cos1 WITH Cos1+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=2
				Replace Peso2 WITH Peso2+cResumenProd.Peso, ;
						Can2 WITH Can2+cResumenProd.Cantidad, ;
						Cos2 WITH Cos2+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=3
				Replace Peso3 WITH Peso3+cResumenProd.Peso, ;
						Can3 WITH Can3+cResumenProd.Cantidad, ;
						Cos3 WITH Cos3+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=4
				Replace Peso4 WITH Peso4+cResumenProd.Peso, ;
						Can4 WITH Can4+cResumenProd.Cantidad, ;
						Cos4 WITH Cos4+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=5
				Replace Peso5 WITH Peso5+cResumenProd.Peso, ;
						Can5 WITH Can5+cResumenProd.Cantidad, ;
						Cos5 WITH Cos5+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=6
				Replace Peso6 WITH Peso6+cResumenProd.Peso, ;
						Can6 WITH Can6+cResumenProd.Cantidad, ;
						Cos6 WITH Cos6+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=7
				Replace Peso7 WITH Peso7+cResumenProd.Peso, ;
						Can7 WITH Can7+cResumenProd.Cantidad, ;
						Cos7 WITH Cos7+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=8
				Replace Peso8 WITH Peso8+cResumenProd.Peso, ;
						Can8 WITH Can8+cResumenProd.Cantidad, ;
						Cos8 WITH Cos8+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=9
				Replace Peso9 WITH Peso9+cResumenProd.Peso, ;
						Can9 WITH Can9+cResumenProd.Cantidad, ;
						Cos9 WITH Cos9+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=10
				Replace Peso10 WITH Peso10+cResumenProd.Peso, ;
						Can10 WITH Can10+cResumenProd.Cantidad, ;
						Cos10 WITH Cos10+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=11
				Replace Peso11 WITH Peso11+cResumenProd.Peso, ;
						Can11 WITH Can11+cResumenProd.Cantidad, ;
						Cos11 WITH Cos11+cResumenProd.Costo IN cVisualPeriodo
			CASE MONTH(cResumenProd.Fecha)=12
				Replace Peso12 WITH Peso12+cResumenProd.Peso, ;
						Can12 WITH Can12+cResumenProd.Cantidad, ;
						Cos12 WITH Cos12+cResumenProd.Costo IN cVisualPeriodo
		ENDCASE 
		SKIP IN cResumenProd
	ELSE 
		INSERT INTO cVisualPeriodo (Codigo, Detalle,CodPro, CodOpe, Nivel, DetOpe) ;
			VALUES (cResumenProd.Codigo, cResumenProd.Detalle, ;
					cResumenProd.CodPro, cResumenProd.Operador, "1", cResumenProd.DetOpe)
	ENDIF 
ENDDO 

UPDATE cVisualPeriodo ;
	SET PesoTot=(Peso1+Peso2+Peso3+Peso4+Peso5+Peso6+ ;
	 			 Peso7+Peso8+Peso9+Peso10+Peso11+Peso12), ;
	 	CanTot=(Can1+Can2+Can3+Can4+Can5+Can6+ ;
	 			Can7+Can8+Can9+Can10+Can11+Can12), ;
	 	CosTot=(Cos1+Cos2+Cos3+Cos4+Cos5+Cos6+ ;
				Cos7+Cos8+Cos9+Cos10+Cos11+Cos12)
DELETE FROM cVisualPeriodo WHERE (PesoTot+CanTot+CosTot)=0

INSERT INTO cVisualPeriodo (Detalle, ;
							Peso1,Peso2,Peso3,Peso4,Peso5,Peso6,;
							Peso7,Peso8,Peso9,Peso10,Peso11,Peso12,;
							Can1,Can2,Can3,Can4,Can5,Can6,;
							Can7,Can8,Can9,Can10,Can11,Can12,;
							Cos1,Cos2,Cos3,Cos4,Cos5,Cos6,;
							Cos7,Cos8,Cos9,Cos10,Cos11,Cos12,;
							CosTot, CanTot, PesoTot, CodOpe, Nivel) ;
	SELECT  "["+ALLTRIM(CodOpe)+"] - "+ALLTRIM(DetOpe), ;
			SUM(Peso1),SUM(Peso2),SUM(Peso3),SUM(Peso4),SUM(Peso5),SUM(Peso6), ;
		    SUM(Peso7),SUM(Peso8),SUM(Peso9),SUM(Peso10),SUM(Peso11),SUM(Peso12), ;
		    SUM(Can1),SUM(Can2),SUM(Can3),SUM(Can4),SUM(Can5),SUM(Can6),;
		    SUM(Can7),SUM(Can8),SUM(Can9),SUM(Can10),SUM(Can11),SUM(Can12),;
		    SUM(Cos1),SUM(Cos2),SUM(Cos3),SUM(Cos4),SUM(Cos5),SUM(Cos6),;
		    SUM(Cos7),SUM(Cos8),SUM(Cos9),SUM(Cos10),SUM(Cos11),SUM(Cos12),;
		    SUM(CosTot), SUM(CanTot), SUM(PesoTot), CodOpe, "0" ;
		FROM cVisualPeriodo ;
		WHERE VAL(Nivel)=1 ;
		GROUP BY CodOpe

	
SELECT cVisualPeriodo	
GO TOP 
BROWSE 

CLOSE ALL
CLEAR ALL
