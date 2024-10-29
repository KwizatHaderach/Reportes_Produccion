CLOSE ALL
CLEAR ALL

stdVia="\\HP-eqs\Ambientes\Ernesto\Copol\Data_Consultas\"

_TablaSelec=stdVia+"LOTEOT.Dbf"

IF FILE(_TablaSelec) THEN 
	DELETE FILE &_TablaSelec
ENDIF 

CREATE TABLE &_TablaSelec (Det_ot_id n(15), CodCmp n(2), Valor n(15,2), Lote c(25))

*!*	El Campo CodCMP adquiere los siguientes valores:
*!*	1=KgAD
*!*	2=KgBD
*!*	3=KgUP
*!*	4=KgLIN
*!*	5=KgRECU
*!*	6=KgELITE
*!*	7=KgMB

CLOSE ALL
CLEAR ALL
