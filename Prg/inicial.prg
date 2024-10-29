CLOSE ALL
CLEAR ALL

SET ECHO OFF
SET TALK OFF
SET DATE TO DMY 
SET CENTURY ON 
SET ENGINEBEHAVIOR 70
SET STRICTDATE TO 0
*SET SYSMENU OFF 
SET EXACT ON 
SET DELETED ON

SET PROCEDURE TO .\Prg\RutinasAlmacenadas.prg

PUBLIC Stdvia, stdViaLoc, stdViaPropia, stdViaLog, stdRecuperaIngresado, ;
	   stNumeroFilasReporte, stdFormaImpresion, _MenuPrincipalOcupado , stdViaCobran, cVersion, stdViaArchivoBlanco, _StdRutaArchivosPDF

IF !FILE("PARAMETROS.DBF") THEN 
	=MESSAGEBOX("Archivo de parametros iniciales, no encontrado")
	RETURN .f.
ENDIF 

_vfp.Visible=.f.

USE Parametros.Dbf 
GO TOP 

stdVia		= ADDBS(ALLTRIM(Parametros.ViaDatos))
stdViaLoc	= ADDBS(ALLTRIM(Parametros.ViaLocal))
stdViaLog	= ADDBS(ALLTRIM(Parametros.ViaLog))
stdViaPropia= ADDBS(ALLTRIM(Parametros.ViaPropio))
stdViaArchivoBlanco = ALLTRIM(Parametros.ViaBlanco)



_StdRutaArchivosPDF=ADDBS(ALLTRIM(Parametros.ViaPDF))
stdViaCobran= ADDBS(ALLTRIM(Parametros.ViaCobran))
cVersion = "2.0.12"
stdFormaImpresion=Parametros.FormaImp

stNumeroFilasReporte = Parametros.NumLinOT
stdRecuperaIngresado =.f.   &&& Variable Global que permite configurar el comportamiento de las ayudas rapidas ;
							&&& para que recuperen el valor que se ha ingresado previamente
*!*	Se debe Comentar en Desarrollo
*!*	_Screen.Visible=.f.

USE IN Parametros

DO FORM .\Form\wPrincipal_Secundario.scx

SET SYSMENU TO DEFAULT 

*!*	Se debe Comentar en Desarrollo
READ EVENTS

CLOSE ALL
CLEAR ALL
RELEASE ALL 
CLEAR MEMORY 


*!*	Se debe comentarse en Produccion
CANCEL 

*!*	Se debe Comentar en Desarrollo
*QUIT 
