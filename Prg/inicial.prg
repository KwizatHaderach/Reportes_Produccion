CLOSE ALL
CLEAR ALL

SET ECHO OFF
SET TALK OFF
SET DATE TO DMY 
SET CENTURY on
SET ENGINEBEHAVIOR 70
SET STRICTDATE TO 0
SET SYSMENU OFF 

SET DELETED ON

SET PROCEDURE TO "J:\Reportes_Consultas(pcv)\Reportes_Consultas(pcv)\Prg\RutinasAlmacenadas.prg"

PUBLIC Stdvia, stdViaLoc, stdViaPropia, stdViaLog, stdRecuperaIngresado, ;
	   stNumeroFilasReporte, stdFormaImpresion, _MenuPrincipalOcupado , stdViaCobran

IF !FILE("PARAMETROS.DBF") THEN 
	=MESSAGEBOX("Archivo de parametros iniciales, no encontrado")
	RETURN .f.
ENDIF 

USE Parametros.Dbf 
GO TOP 

stdVia		= ADDBS(ALLTRIM(Parametros.ViaDatos))
stdViaLoc	= ADDBS(ALLTRIM(Parametros.ViaLocal))
stdViaLog	= ADDBS(ALLTRIM(Parametros.ViaLog))
stdViaPropia= ADDBS(ALLTRIM(Parametros.ViaPropio))
_StdRutaArchivosPDF=ADDBS(ALLTRIM(Parametros.ViaPDF))
stdViaCobran= ADDBS(ALLTRIM(Parametros.ViaCobran))

stdFormaImpresion=Parametros.FormaImp

stNumeroFilasReporte = Parametros.NumLinOT
stdRecuperaIngresado =.f.   &&& Variable Global que permite configurar el comportamiento de las ayudas rapidas ;
							&&& para que recuperen el valor que se ha ingresado previamente

_Screen.Visible=.f.

USE IN Parametros

*!*	DO FORM C:\Reportes_Consultas(pcv)\Form\wPrincipal.scx
SET STEP ON 
DO FORM J:\Reportes_Consultas(pcv)\Reportes_Consultas(pcv)\Form\wPrincipal_Secundario.scx

SET SYSMENU TO DEFAULT 

READ EVENTS

CLOSE ALL
CLEAR ALL
RELEASE ALL 
CLEAR MEMORY 

QUIT 




