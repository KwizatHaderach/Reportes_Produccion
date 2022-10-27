CLOSE ALL
CLEAR ALL

USE \\ServerCopol\Sisgen\Datos\Producto IN 0
USE Cambio_Productos IN 0 

GO TOP IN Cambio_Productos
DO WHILE !EOF("CAMBIO_PRODUCTOS")
	IF !SEEK(Cambio_Productos.Codigo, "PRODUCTO",1) THEN 
		? Cambio_Productos.Codigo
	ENDIF 
	
	IF !Producto.BobiMadre THEN 
		? "Producto no Transformado"
	ENDIF 
		
*	Replace Producto.BobiMadre WITH .t. IN Producto
	
	SKIP IN Cambio_Productos
ENDDO 

CLOSE ALL
CLEAR ALL

	
	