<h1 align="center" style="border-bottom: none">
    <b>
        PROYECTO DE ESTUDIO BASES DE DATOS I 
    </b>
</h1>
<h3 align="center">
     Licenciatura en Sistemas de Información <br>
     Facultad de Ciencias Exactas y Naturales y Agrimensura <br>
     Universidad Nacional del Nordeste <br><br>
     <img src="https://user-images.githubusercontent.com/88750038/201496946-7b4cb184-6102-419e-a8a7-75e42fc30723.png" alt="MDN">
</h3>

##

<h2 align="center">
 Base de Datos Para Juego RPG<br>
 Año 2022 <br>
</h2>

### **Integrantes Grupo 09**

- Falk, Franco Sebastian
- Gomez, Victor Agustin
- Mancedo, Joaquin
- Riquelme, Rodolfo Ivan
- Ruiz Diaz, Emmanuel

## **CAPITULO I**

### **Descripción del Proyecto y Alcance del Proyecto**

El desarrollo del proyecto del modelo de datos de un videojuego online, pretende llevar a cabo una base de datos relacional sólida para la creación de dicho juego, centrado mas precisamente en el RPG (Role-Play-Gaming).

Entre las posibilidades de nuestra base, buscamos principalmente los siguientes objetivos a llevar a cabo:

- Creación de cuentas.
- Creación de personajes con sus atributos.
- Manejo de ítems con sus atributos.
- Manejo de inventario con sus respectivos ítems.
- Manejo de Tiendas con sus respectivos ítems.
- Manejo de Npcs con sus atributos.
- Manejo de mapas, con sus respectivos personajes, npcs (neutrales, hostiles, bosses), tiendas.

Con estas características cubiertas de base, podríamos ir ampliando a futuro con nuevas funcionalidades, ya sean sistemas de quest, comercio entre usuarios, bancos, etc.

## **CAPITULO II**

- Creamos un lote de datos e hicimos distintos tipos de operaciones para corroborar el correcto funcionamiento de la base con los distintos tipos de operaciones ABM.
- En cuanto a triggers, tenemos uno en el que se instancian las estadisticas de un personaje al crearlo.
- Poseemos una transaccion, que se encarga de actualizar las estadisticas de los personajes dependiendo del item equipado.
- El modelo posee distintos tipos de vista, que serviran como por ejemplo, para ver la lista completa de personajes en una cuenta u obtener una lista detallada de items que existen en el juego.
- A partir de las necesidades de cada usuario que va a acceder a la base de datos, tendran su respectivo rol. Con sus correspondientes permisos y restricciones.
- La base de datos esta lista para realizar backups y restauraciones.

## **CAPITULO III**

Usamos como metodologia reuniones en la plataforma Google MEET, donde pactabamos las tareas que hacian falta para el proyecto. Luego ese listado de tareas lo subiamos a la plataforma TRELLO, donde cada colaborador podia asignarse tareas, las cuales se dividian en "En proceso" "Finalizados, por subir" "Finalizados, subidos".
Para que cada colaborador pudiera hacer y ver los cambios de los otros en el proyecto, optamos por la plataforma de GitHub.

## **CAPITULO IV**

(implementación)

Diagrama del Modelo de datos Der 
![image](https://user-images.githubusercontent.com/88750038/201694566-d86478dd-24e9-4c91-876b-e9587221a6aa.png)


Entidades (descripción de las tablas)

Diccionario de datos (descripción de los atributos de cada tabla)

## **CAPITULO V**

(conclusiones / dificultades / desafíos o perspectivas)

## **BIBLIOGRAFÍA**

(material de lectura/consulta que se utilizó para el desarrollo del trabajo)

### ANEXO Videos Script SQL Documentación complementaria


https://learn.microsoft.com/es-es/sql/t-sql/statements/statements?view=sql-server-ver16

https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server?view=sql-server-ver16

https://learn.microsoft.com/en-us/sql/t-sql/statements/create-login-transact-sql?view=sql-server-ver16

https://learn.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver16

https://learn.microsoft.com/es-es/sql/t-sql/language-elements/transactions-transact-sql?view=sql-server-ver16

https://learn.microsoft.com/es-es/sql/t-sql/statements/create-procedure-transact-sql?view=sql-server-ver16
