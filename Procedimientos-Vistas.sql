
--Vista de items con sus respectivas tiendas
CREATE OR ALTER VIEW ArticulosEnTiendas
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

--Vista de los personajes de las cuenta
CREATE OR ALTER VIEW CuentaPersonajes
AS 
SELECT pe.id_usuario, pe.id_personaje, pe.nombre_personaje, cl.nombre_clase as 'Clase'
FROM personajes pe
INNER JOIN clases cl
ON pe.id_clase = cl.id_clase
GO
--Vista de los personajes de en las cuenta con sus detalles
CREATE OR ALTER VIEW CuentaPersonajesDetalles
AS
SELECT pe.id_usuario, pe.id_personaje,cp.nombre_personaje,cp.Clase,es.nivel,es.experiencia,pe.oro,pe.mana,es.vida,es.fuerza,es.agilidad,es.magia
FROM personaje_estadistica pe
INNER JOIN estadisticas es
ON pe.id_estadistica = es.id_estadistica
INNER JOIN CuentaPersonajes cp 
ON pe.id_personaje = cp.id_personaje
GO

--select * from CuentaPersonajes 
--select * from CuentaPersonajesDetalles

--INSTANCIA LAS ESTADISTICAS POR DEFAULT AL MOMENTO DE CREAR UN NUEVO PERSONAJE
--Mago: Fuerza 25, Agilidad 50, Magia 100
--Guerrero: Fuerza 100, Agilidad 50, Magia 0
--Arquero: Fuerza 50, Agilidad 100, Magia 0

GO
CREATE OR ALTER TRIGGER InstanciarEstadisticas
ON personajes FOR INSERT AS
BEGIN 
	DECLARE @idUsuario INT
	DECLARE @IdPersonaje INT
	DECLARE @idClase int
	DECLARE @IdEstadistica INT
	SELECT @idUsuario = INSERTED.id_usuario
	FROM INSERTED
	SELECT @IdPersonaje = INSERTED.id_personaje
	FROM INSERTED

	--Instanciar una estadistica
	IF (SELECT INSERTED.id_clase from INSERTED) = 1
		INSERT INTO estadisticas(vida,nivel,experiencia,fuerza,agilidad,magia) VALUES (100,0,0,50,100,0);
	ELSE IF (SELECT INSERTED.id_clase from INSERTED) = 2
		INSERT INTO estadisticas(vida,nivel,experiencia,fuerza,agilidad,magia) VALUES (100,0,0,100,50,0);
	ELSE IF (SELECT INSERTED.id_clase from INSERTED) = 3
		INSERT INTO estadisticas(vida,nivel,experiencia,fuerza,agilidad,magia) VALUES (100,0,0,50,100,0);
	--Almaceno el id de la estadistica 
	SELECT @IdEstadistica = id_estadistica FROM estadisticas WHERE id_estadistica=(SELECT max(id_estadistica) FROM estadisticas);
	--Instaciar personaje_estadistica

	INSERT INTO personaje_estadistica(id_usuario,id_personaje,id_estadistica,oro,mana) VALUES (@idUsuario,@IdPersonaje,@IdEstadistica,100,100);
END
GO

CREATE OR ALTER VIEW npcsView
AS
SELECT np.id_npc,tp.nombre_tipo,np.nombre_npc,np.estatico
FROM npcs np
INNER JOIN npcs_tipos tp
ON np.id_tipo = tp.id_tipo
GO
--select * from npcsView
CREATE OR ALTER VIEW npcsBoss
AS
Select * from npcsView WHERE nombre_tipo='Boss' 
GO
Select * from npcsBoss

--Vista de los usuarios con sus items en inventario
CREATE OR ALTER usuPer_Items
AS
	SELECT pr.id_usuario, pr.id_personaje,i.cant_slots,i.id_item,i.slot, it.nombre FROM 
	(
		SELECT ini.id_inventario,ini.id_item, ini.slot, inv.cant_slots FROM inventarios_items ini
		INNER JOIN inventarios inv
		ON ini.id_inventario = inv.id_inventario 
	) i
	INNER JOIN personajes pr 
	ON i.id_inventario = pr.id_inventario
	INNER JOIN items it
	ON i.id_item = it.id_item
GO
--SELECT* FROM usuPer_Items

--Vista de los items con sus caracteristicas
CREATE OR ALTER VIEW itemsCaracteristicas
AS
	SELECT it.id_item, it.nombre, ei.agilidad,ei.fuerza,ei.magia,ei.poder_ataque,ei.poder_defensa,ei.poder_magico FROM items_estadistica_item ie
	inner join items it
	on ie.id_item = it.id_item
	INNER JOIN estadisticas_item ei
	on ie.id_estadistica_item = ei.id_estadistica_item
GO
--Vista de los personajes con sus items con sus respectivas caracteristicas
CREATE OR ALTER VIEW personajeItems
as
SELECT ui.id_usuario, ui.id_personaje,ui.slot, itc.nombre, itc.agilidad, itc.fuerza, itc.magia, itc.poder_ataque, itc.poder_defensa, itc.poder_magico FROM usuPer_Items ui
inner join itemsCaracteristicas itc
on ui.id_item = itc.id_item
go

--funcion para filtrar los items de cada personaje y usuario
CREATE OR ALTER FUNCTION GetinventarioPer(@id_usu as int,@id_per as int)
RETURNS TABLE  
AS  
RETURN  SELECT * FROM personajeItems where id_usuario=@id_usu and id_personaje=@id_per

--SELECT * FROM GetinventarioPer(1,2)


--COSAS POR HACER E IDEAS
--CK_Personaje_Items...
--Un personaje no puede tener en su inventario un item que no pertenezca a su categoria


--CK_StockItem_Tienda...
--Control de stock de los items en la tienda(cantidad disponible)


--TRIGGER INSTANCIAR ESTADISTICAS POR DEFAULT (LISTO)
--Valores por defecto al crear un personaje, dependiendo la clase del mismo


--Vista personajes y NPCS en mapa

--Vista personajes en una cuenta (LISTO)

--Vista NPCS  (LISTO)

--Vista NPCS BOSS (LISTO)

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