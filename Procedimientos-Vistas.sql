
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

--TRIGGER PARA INSTANCIAR LAS ESTADISTICAS DE UN PERSONAJE AL MOMENTO DE CREARLOS
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
--VISTAS DE LOS NPCS
CREATE OR ALTER VIEW npcsView
AS
SELECT np.id_npc,tp.nombre_tipo,np.nombre_npc,np.estatico
FROM npcs np
INNER JOIN npcs_tipos tp
ON np.id_tipo = tp.id_tipo
GO
--select * from npcsView
--VISTAS DE LOS NPCS BOSS
CREATE OR ALTER VIEW npcsBoss
AS
	Select * from npcsView WHERE nombre_tipo='Boss' 

GO
--Select * from npcsBoss

--Vista de los usuarios con sus items en inventario
CREATE OR ALTER VIEW usuPer_Items
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

go
--SELECT * FROM GetinventarioPer

--VISTAS DE CUENTAS ACTIVAS Y NO ACTIVAS
go
CREATE OR ALTER VIEW cuentasActivas
AS
	SELECT * FROM cuentas
	where estado = 1
GO
CREATE OR ALTER VIEW cuentasNOActivas
AS
	SELECT * FROM cuentas
	where estado = 0
GO
--VISTAS DE PERSONAJES ONLINE
CREATE OR ALTER VIEW personajesActivos
AS
	SELECT * FROM personajes
	where estado_online = 1
GO
CREATE OR ALTER VIEW personajesActivos
AS
	SELECT * FROM personajes
	where estado_online = 0
GO
--VISTA DE UBICACION DE NPC EN EL MAPA 
CREATE VIEW npc_mapa
AS
SELECT mn.id_npc 'id npc',n.nombre_npc 'nombre',mn.id_mapa 'id mapa',m.nombre_mapa 'nombre de mapa', CONCAT(mn.coord_x,'-',mn.coord_y) 'cordenada' FROM mapas_npcs mn
INNER JOIN npcs n
ON mn.id_npc = n.id_npc
INNER JOIN mapas m
ON mn.id_mapa = m.id_mapa
GO

--BACKUP Y RESTAURACION 

--backup completo
BACKUP DATABASE bd_juego_g9
TO DISK = 'C:\data\bd_juego_g9.bak'
WITH NAME = 'BACKUPCOMPLETO'
GO

--backup diferencial
BACKUP DATABASE  bd_juego_g9
TO DISK = 'C:\data\bd_juego_g9.bak'
WITH DIFFERENTIAL
GO


--Informacion de los backup dentro del archivo .bak 
RESTORE HEADERONLY 
FROM DISK = 'C:\data\bd_juego_g9.bak'

--procedimiento de creacion de backup
CREATE PROC copiaBD @bd VARCHAR(20),@nomcopia VARCHAR(30)
AS
DECLARE @procedimiento VARCHAR(100)
SET @procedimiento='backup database '+@bd +' to disk=' +CHAR(39)+'C:\data\'+@nomcopia+'.bak'+char(39)
EXEC (@procedimiento)
GO

copiaBD 'bd_juego_g9','copia12r'

---------RESTORE DE BACKUP COMPLETO 
--RESTORE DATABASE bd_juego_g9 FROM DISK= 'C:\data\bd_juego_g9.bak'

---------Creacion de usuarios y roles  
--usuario dev
--puede hacer select a todas las tablas de la base 
CREATE LOGIN logDEV WITH PASSWORD = '1234'
CREATE USER dev FOR LOGIN logDEV
ALTER ROLE db_datareader ADD member dev
--usuario admin
--pueden ejecutar cualquier comando del lenguaje de definición de datos (DDL) en una base de datos. 
CREATE LOGIN logAdmin WITH PASSWORD = '1234'
CREATE USER admi FOR LOGIN logAdmin
ALTER ROLE db_ddladmin ADD member admi
--usuario backup
-- pueden crear copias de seguridad de la base de datos.
CREATE LOGIN logBack WITH PASSWORD = '1234'
CREATE USER back FOR LOGIN logBack
ALTER ROLE db_backupoperator ADD member back
--usuario de seguridad
-- ueden modificar la pertenencia a roles únicamente para roles personalizados y administrar permisos.
CREATE LOGIN logSeguridad WITH PASSWORD = '1234'
CREATE USER seguridad FOR LOGIN logSeguridad
ALTER ROLE db_securityadmin ADD member seguridad




