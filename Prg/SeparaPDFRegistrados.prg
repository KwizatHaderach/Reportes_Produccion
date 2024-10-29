CLOSE ALL
CLEAR ALL
SET SAFETY OFF

stdVia = "C:\Desarrollos\Copol\Data_Consultas\"
stdViaRepositorioPDF = "C:\Desarrollos\Copol\RepositorioPDF\"

*//stdViaRepositorioPDFOriginal = "C:\Desarrollos\Copol\PDF\"

USE stdVia+"ORDTRA.Dbf" IN 0 
USE stdVia+"DETOTPDF.Dbf" IN 0 

ZAP IN DetOTPDF

SELECT * FROM OrdTra WHERE !EMPTY(ALLTRIM(OrdTra.PDFAsigna)) INTO CURSOR cTotales



GO TOP IN cTotales
DO WHILE !EOF("cTOTALES") 
	NombreActivo = JUSTFNAME(cTotales.PDFAsigna)
	PrefijoOT = "_OT"+ALLTRIM(STR(cTotales.OT_ID))
	
	= ADIR(aArchivos,stdViaRepositorioPDF+"*.pdf")	
	
	IF FILE(ALLTRIM(cTotales.PDFAsigna)) THEN 
		_NuevoArchivo = stdViaRepositorioPDF + NombreActivo
		FOR vI = 1 TO ALEN(aArchivos, 1)
			IF UPPER(ALLTRIM(aArchivos(vI,1))) == UPPER(ALLTRIM(NombreActivo)) THEN 	
				_NuevoArchivo = stdViaRepositorioPDF + PrefijoOT + NombreActivo
				EXIT 
			ENDIF 
		ENDFOR 
		
		COPY FILE (cTotales.PDFAsigna) TO (_NuevoArchivo)
		
		INSERT INTO DetOTPDF (NomArch, OTID) ;
			VALUES (NombreActivo, cTotales.OT_ID)
	ELSE 
		? "Via No Valida : " + ALLTRIM(cTotales.PDFAsigna)
	ENDIF 
	
	SKIP IN cTotales
ENDDO 

CLOSE ALL
CLEAR ALL
