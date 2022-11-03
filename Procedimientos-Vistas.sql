--Vistas

--Vista de items con sus respectivas tiendas
ALTER VIEW ArticulosEnTiendas
AS 
SELECT t.id_tienda as 'idTienda', t.cant_slots as 'Slots', t.nombre as 'Nombre Tienda',i.nombre as 'Articulo',c.titulo_categoria as 'Categoria',ti.precio,ti.cantidad
FROM tiendas_items ti
INNER JOIN items i
ON ti.id_item = i.id_item
INNER JOIN tiendas t 
ON ti.id_tienda = t.id_tienda
INNER JOIN categorias c
ON i.id_categoria = c.id_categoria
--WHERE t.id_tienda = 1
GO 




--Procedimientos

--Comprobar disponibilidad de slots de la tienda para ingresar items en la misma
ALTER FUNCTION ComprobarSlots(@Idt as int)
RETURNS int
AS 
BEGIN
   DECLARE @retval int
   SELECT @retval = (SELECT cant_slots FROM tiendas where id_tienda = @Idt) - (SELECT COUNT(*) FROM ArticulosEnTiendas WHERE ArticulosEnTiendas.idTienda = @Idt)
   RETURN @retval
END;
GO


--CK_Personaje_Items...
--Un personaje no puede tener en su inventario un item que no pertenezca a su categoria


--CK_StockItem_Tienda...
--Control de stock de los items en la tienda(cantidad disponible)


--DF_Estadisticas_Segun_ClasePersonaje
--Valores por defecto al crear un personaje, dependiendo la clase del mismo


--Vista personajes y NPCS en mapa

--Vista personajes en una cuenta

--Vista NPCS BOSS

--Vista personajes conectados

--Vista Items con sus estadisticas
--Listado de todos los items con sus estadisticas y categorias

--Vista Inventario Personaje
----Listado de todos los items en el inventario del pesonaje con sus estadisticas y categorias 
--(se puede utilizar la vista de items) y filtar 

--CK_NivelMax
--Nivel maximo del personaje (100)

--Estado en cuenta (Eliminacion Logica)
--Agregar como atributo en cuenta
--estado bit 

--Vista de cuentas activas o Eliminadas
--Vista Activos
	--where estado = 1
--Vista No Activos
	--where estado = 0

--Estado Online en Personaje
--estado_online bit
--Vista Activos
	--where estado = 1
--Vista No Activos
	--where estado = 0

--DF_EstadoActivoCuenta
--Estado activo en cuenta

--DF_SlotInventario
--Cantidad de espacio disponible (5)


--Temas t�cnicos de trabajo

--Transacciones 
--Pasos para la compra
	--Control de stock en la tienda...
	--Espacio libre en Inventario personaje
	--Oro mayor al total...

--Si la compra se realizo correctamente...
--Triggers
	--Descontar Stock en Tienda
		--Si cantidad de items en tienda es 0 se elimina de la tienda
	--Descontar Oro
	--Aumentar el espacio en inventario y se agrega el item


--Vistas. (completo)

--Permisos. 
--Admin (MANEJO DE TABLAS (CREAR - ELIMINAR - ACTUALIZAR)
--DEV (READ - AGREGAR REGISTROS - ACTUALIZAR REGISTROS)
--

--Manejo de datos multimediales en bases de datos relacionales
--Imagen de Perfil en Cuenta (Insertar enlace como imagen)
--https://cloudinary.com/
--Agregar url_imagenPerfil en cuenta (String)

--Backup y restauraci�n.
-- Backup diarios de algunas tablas y uno semanal de la base completa



--COSAS POR HACER

--CREAR TABLAS COMPRA Y DETALLE
-- Realizar la transaccion con los triggers

--A�adir atributo eliminaciones logicas en Cuenta y Personaje
--Generar vistas de activos en Cuenta y Personaje
--DF_EstadoActivoCuenta

--Generar vistas (Ya se pueden realizar)
--Vista personajes y NPCS en mapa
--Vista personajes en una cuenta
--Vista NPCS BOSS
--Vista Items con sus estadisticas
--Vista Inventario Personaje


--CHECKS
--CK_NivelMax
--CK_Personaje_Items
--CK_StockItem_Tienda
--DF_SlotInventario
--DF_Estadisticas_Segun_ClasePersonaje


--Manejo de datos multimediales en bases de datos relacionales
--Imagen de Perfil en Cuenta (Insertar enlace como imagen)
	--Agregar url_imagenPerfil en cuenta (String)

--Backup y restauraci�n.
-- Backup diarios de algunas tablas y uno semanal de la base completa



--COMPLETAR EL INFORME

--CAPITULO I
	--c. Objetivo del Trabajo Pr�ctico.
		--Responde a la pregunta �para qu� realizo el Trabajo Pr�ctico? �Qu� puede esperar el lector
		--del trabajo que voy a realizar? En este nivel se deben especificar los
		--i. Objetivos Generales.
		--Resultado general esperado con el trabajo. El objetivo general debe
		--responder al Problema principal.
		--ii. Objetivos Espec�ficos.
		--Resultados particulares esperados. Guardan relaci�n con las preguntas
		--expresadas al inicio del Cap�tulo. 
--CAPITULO II
--(Marco te�rico. Ac� se debe explicar brevemente los conceptos sobre los temas t�cnicos de los motores de bases de datos que se asign� a cada grupo)

--CAPITULO III
--(metodolog�a / herramientas)


	--Metodologia
		--Descripci�n de c�mo se realiz� el Trabajo Pr�ctico.
	--Herramientas
		--Motor de base datos (todo lo relacionado)
		--Git
		--Github
--CAPITULO IV
--Entidades
--(descripci�n de las tablas)

--Diccionario de datos
--(descripci�n de los atributos de cada tabla)
