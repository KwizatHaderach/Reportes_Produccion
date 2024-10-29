CLOSE ALL
CLEAR ALL

USE C:\Desarrollos\Copol\datos\Clipagos IN 0
USE C:\Desarrollos\Copol\datos\CodPagos IN 0
USE C:\Desarrollos\Copol\datos\Clientes IN 0
USE C:\Desarrollos\Copol\datos\CodBanco IN 0


*!*	INSERT INTO cPagosCHQCur (strCodPag, FolioDoc, FecIng, FecDoc, BancoDoc, Monto, strTipoDoc, ;
*!*							  Folio, Rut, RazonSoc, NumDepo, FecDepo, BancoDep, TipoDoc, ;
*!*							  CodBcoOri, CodBcoDep, CodPag);



*!*	SELECT cp.Descri, NumDoc, FecPag, FecDoc, cb.Descri, Monto, ICASE(tDocto = "PA", "PAGO MULTIPLE", tDocto = "FE", "FACTURA ELECTRONICA", "FACTURA MANUAL"), ;
*!*		   NumFac, RutCli, cl.clNombre, NumDepo, FecDepo, BcoDepo, tDocto, BcoDoc, BcoDepo, CodPag ;
*!*		FROM Clipagos clp ;
*!*		LEFT JOIN CodPagos cp ON clp.CodPag = cp.Codigo ;
*!*		LEFT JOIN CodBanco cb cp ON clp.BcoDoc = cb.Codigo ;
*!*		LEFT JOIN Clientes cl cp ON clp.RutCli = cl.clRut ;
*!*		WHERE CodPag In (SELECT Codigo FROM cCodPagAut) ;
*!*		ORDER BY FecDoc ;
*!*		INTO CURSOR cPagosCheque READWRITE 

SELECT cp.Descri, clp.NumDoc, clp.FecPag, clp.FecDoc, NVL(cb.Descri, "") as BancoDoc, clp.ValDoc, ICASE(tDocto = "PA", "PAGO MULTIPLE", tDocto = "FE", "FACTURA ELECTRONICA", "FACTURA MANUAL") as TipoDoc,;
	   clp.NumFac, clp.RutCli, cl.clNombre, clp.NumDepo, clp.FecDepo, clp.BcoDepo as BcoDepo, clp.tDocto, clp.BcoDoc, clp.BcoDepo as CodBcoDepo, clp.CodPag, ;
	   (RutCli+DTOC(FecPag)+" "+ALLTRIM(STR(ValDoc,15,0))+tDocTo+NumFac+CodPag);
	FROM Clipagos as clp ;
	LEFT JOIN CodPagos as cp ON clp.CodPag = cp.Codigo ;
	LEFT JOIN CodBanco as cb ON clp.BcoDoc = cb.Codigo ;
	LEFT JOIN Clientes as cl ON clp.RutCli = cl.clRut ;
	WHERE cp.tiPago = 2;
	ORDER BY FecDoc ;
	INTO CURSOR cPagosCheque READWRITE 

SELECT cPagosCheque
GO TOP 
BROWSE 

CLOSE ALL
CLEAR ALL
