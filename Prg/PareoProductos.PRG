CLOSE ALL
CLEAR ALL
***** Prueba para verificar que todos los codigos de equivalencia esten en la tabla numSerie

SET DELETED ON
SET DATE TO dmy
SET CENTURY on
SET ENGINEBEHAVIOR 70

USE \\SERVERCOPOL\sisgen\datos\Clidocto IN 0
USE \\SERVERCOPOL\sisgen\datos\NumSerie IN 0
USE \\SERVERCOPOL\sisgen\datos\Producto IN 0

SELECT PADL(ALLTRIM(STR(MONTH(CliDocto.FecFac))),2,"0")+PADL(ALLTRIM(STR(YEAR(CliDocto.FecFac))),4,"0") as Periodo, ;
	   PADL(ALLTRIM(STR(YEAR(CliDocto.FecFac))),4,"0")+PADL(ALLTRIM(STR(MONTH(CliDocto.FecFac))),2,"0") as PeriodoORden, CNT(*) ;
	FROM CliDocto ;
	GROUP BY Periodo ;
	ORDER BY PeriodoOrden ;
	INTO CURSOR cPeriodos

vCodigosSEquivalencia=0

GO TOP IN cPeriodos
DO WHILE !EOF("cPERIODOS")
	vTablaSelec="\\SERVERCOPOL\SISGEN\Datos\DT"+cPeriodos.Periodo+".DBF"
	
	WAIT WINDOW "Periodo: "+vTablaSelec NOWAIT 
	
	IF !FILE(vTablaSelec) THEN 
		SKIP IN cPeriodos
		LOOP
	ENDIF 
	
	USE &vTablaSelec ALIAS tMovim IN 0
	
	GO TOP IN tMovim
	DO WHILE !EOF("tMOVIM")
		IF !EMPTY(ALLTRIM(tMovim.CodPro)) THEN 
			SKIP IN tMovim
			LOOP
		ENDIF 
		
		IF SEEK(tMovim.CodPro, "PRODUCTO",1) THEN 
			IF Producto.Serie="N" THEN 
				SKIP IN tMovim
				LOOP
			ENDIF 
		ELSE
			SKIP IN tMovim
			LOOP
		ENDIF 
		
		IF !SEEK(tMovim.CodPro+tMovim.Observ, "NUMSERIE",2) THEN 
			vCodigosSEquivalencia=vCodigosSEquivalencia+1
		ENDIF
		
		SKIP IN tMovim
	ENDDO 
	
	USE IN tMovim
		
	SKIP IN cPeriodos
ENDDO  

=MESSAGEBOX("Se obtuvieron: "+ALLTRIM(STR(vCodigosSEquivalencia))+", Codigos sin equivalencia")
		
CLOSE ALL
CLEAR ALL
