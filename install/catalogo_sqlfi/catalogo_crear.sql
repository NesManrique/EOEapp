----------------------------------------------------------------------------------------
-- Fecha de Creacion	 : 02/05/2006 
-- Fecha de Modificacion : 04/11/2012
-- Autor Intelectual	 : Juan Carlos Eduardo 
-- Descripcion			 : Script de creacion del catalogo difuso en la Base de Datos
--						   en un esquema llamado SQLfi.
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
-------------------------		GRUPO		--------------------------------
----------------------------------------------------------------------------------------
CREATE TABLE SQLfi_Grupo (
	Nombre VARCHAR(30) NOT NULL,
	PRIMARY KEY(Nombre)
);

----------------------------------------------------------------------------------------
-------------------------		PERMISO		--------------------------------
----------------------------------------------------------------------------------------
CREATE TABLE SQLfi_Permiso (
	Id SERIAL UNIQUE,
	Accion VARCHAR(30) NOT NULL,
	Objeto VARCHAR(30) NOT NULL,
	UNIQUE (Accion,Objeto),
	PRIMARY KEY (Id) 	
);

CREATE TABLE SQLfi_Permiso_Grupo (
	Id_Permiso INTEGER NOT NULL,
	Grupo VARCHAR(30) NOT NULL,
	PRIMARY KEY(Id_Permiso,Grupo),
	FOREIGN KEY (Id_Permiso) 	
		  REFERENCES SQLfi_Permiso (Id) 
		  ON DELETE CASCADE,
	FOREIGN KEY (Grupo) 	
		  REFERENCES SQLfi_Grupo (Nombre) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------		Base de Datos   --------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Bd (
	Dns Varchar(100) NOT NULL,
	Ip VARCHAR(15) NOT NULL,
	NombreBd VARCHAR(30) NOT NULL,
	Puerto INTEGER NOT NULL,
	PRIMARY KEY (Dns)
);

----------------------------------------------------------------------------------------
-------------------------		USUARIO		--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Usuario (
	Usuario SERIAL UNIQUE,
	Login VARCHAR(30) NOT NULL,
	Bd VARCHAR(100) NOT NULL,
	Grupo VARCHAR(30) NOT NULL,
	Clave VARCHAR(10) NOT NULL,
	PRIMARY KEY(Usuario),
	UNIQUE(Login,bd),
	FOREIGN KEY (BD) REFERENCES SQLfi_Bd (Dns) ON DELETE CASCADE,
	FOREIGN KEY (Grupo) 	
		  REFERENCES SQLfi_Grupo (Nombre) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------	TERMINO DIFUSO		--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Termino_Difuso (
	Codigo SERIAL UNIQUE, 
	Identificador VARCHAR(40) NOT NULL,
	Propietario   INTEGER NOT NULL,
	Tipo INTEGER NOT NULL CHECK (Tipo IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14)),
									  -- 1  = Predicado Conjunto 
									  -- 2  = Predicado Condicion
									  -- 3  = Cuantificador 
									  -- 4  = Modificador Potencia 
									  -- 5  = Modificador Translacion
									  -- 6  = Modificador Norma
									  -- 7  = Conector 
									  -- 8  = Comparador Conjunto
									  -- 9  = Comparador Relacion 
									  -- 10 = Tabla 
									  -- 11 = Tabla Difusa
									  -- 12 = Vista 
									  -- 13 = Vista difusa 
									  -- 14 = Asercion
	PRIMARY KEY(Codigo),
	UNIQUE (Identificador, Propietario),
	FOREIGN KEY (Propietario) 	
		  REFERENCES SQLfi_Usuario (Usuario) 
		  ON DELETE CASCADE  
);

----------------------------------------------------------------------------------------
-------------------------	PREDICADO  DIFUSO	--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Predicado_Condicion (
	Codigo_Termino INTEGER   NOT NULL,
	Condicion VARCHAR(256) NOT NULL,
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------	COMPARADORES DIFUSO	--------------------------------
----------------------------------------------------------------------------------------
CREATE TABLE SQLfi_Comparador_Difuso (
	Codigo_Termino INTEGER NOT NULL,
	Tipo INTEGER NOT NULL CHECK (Tipo IN (0,1,2)), 
									-- 0 = Potencia 
									-- 1 = Traslacion 
									-- 2 = Norma
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------	MODIFICADORES DIFUSO	--------------------------------
----------------------------------------------------------------------------------------
-- Modificador por Potencia
CREATE TABLE SQLfi_Modificador_Potencia (
	Codigo_Termino INTEGER NOT NULL, 
	Potencia FLOAT NOT NULL CHECK (Potencia >= 0),
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

-- Modificador por Traslacion
CREATE TABLE SQLfi_Modificador_Trans (
	Codigo_Termino INTEGER NOT NULL, 
	Translacion FLOAT NOT NULL,
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

-- Modificador por Norma
CREATE TABLE SQLfi_Modificador_Norma (
	Codigo_Termino INTEGER NOT NULL,
	Expresion VARCHAR(256) NOT NULL,
	Repeticiones INTEGER NOT NULL CHECK(Repeticiones >= 0),
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);


----------------------------------------------------------------------------------------
-------------------------	CUANTIFICADOR DIFUSO	--------------------------------
----------------------------------------------------------------------------------------
CREATE TABLE SQLfi_Cuantificador_Difuso (
	Codigo_Termino INTEGER NOT NULL,
	Tipo INTEGER NOT NULL CHECK (Tipo IN (0,1)), 
									-- 0 = absoluto
									-- 1 = relativo
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------	CONECTOR  DIFUSO	--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Conector_Difuso (
	Codigo_Termino INTEGER NOT NULL,
	Expresion VARCHAR(256) NOT NULL,
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------	CONJUNTO DIFUSO		--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Conjunto_Difuso (
	Codigo_Termino INTEGER NOT NULL,
	Tipo INTEGER NOT NULL CHECK (Tipo IN (1,2,3,4)),
										-- 1 = Trapecio 
										-- 2 = Expresion 
										-- 3 = Extension escalar 
										-- 4 = Extension numerica
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Conjunto_Trapecio (
	Codigo_Conjunto INTEGER NOT NULL,
	Coord_A FLOAT NOT NULL,
	Coord_B FLOAT NOT NULL,
	Coord_C FLOAT NOT NULL,
	Coord_D FLOAT NOT NULL,
	PRIMARY KEY (Codigo_Conjunto),
	FOREIGN KEY (Codigo_Conjunto) 	
		  REFERENCES SQLfi_Conjunto_Difuso (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Conjunto_Expresion (
	Codigo_Conjunto INTEGER NOT NULL,
	Expresion VARCHAR(256) NOT NULL,
	PRIMARY KEY (Codigo_Conjunto),
	FOREIGN KEY (Codigo_Conjunto) 	
		  REFERENCES SQLfi_Conjunto_Difuso (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Elemento_Escalar (
	Codigo_Conjunto INTEGER NOT NULL,
	Elemento VARCHAR(20)  NOT NULL,
	Membresia FLOAT NOT NULL CHECK (Membresia >= 0.0 AND Membresia <= 1.0),
	PRIMARY KEY (Codigo_Conjunto, Elemento),
	FOREIGN KEY (Codigo_Conjunto) 	
		  REFERENCES SQLfi_Conjunto_Difuso (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Elemento_Numerico (
	Codigo_Conjunto INTEGER NOT NULL,
	Elemento FLOAT NOT NULL,
	Membresia FLOAT NOT NULL CHECK (Membresia >= 0.0 AND Membresia <= 1.0),
	PRIMARY KEY (Codigo_Conjunto, Elemento),
	FOREIGN KEY (Codigo_Conjunto) 	
		  REFERENCES SQLfi_Conjunto_Difuso (Codigo_Termino) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
----------------------------		DOMINIO		--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Dominio (
	Codigo_Termino INTEGER NOT NULL,
	Tipo INTEGER NOT NULL CHECK (Tipo IN (1,2,3,4,5)), 
										-- 1 = Escalar 
										-- 2 = Numerico 
										-- 3 = Fecha 
										-- 4 = Hora 
										-- 5 = Tuple
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Dominio_Numerico (
	Codigo_Dominio INTEGER NOT NULL,
	Dom_Inf FLOAT NOT NULL,
	Dom_Sup FLOAT NOT NULL,
	PRIMARY KEY (Codigo_Dominio),
	FOREIGN KEY (Codigo_Dominio) 	
		  REFERENCES SQLfi_Dominio (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Dominio_Escalar (
	Codigo_Dominio INTEGER NOT NULL,
	Dominio VARCHAR(20) NOT NULL,
	PRIMARY KEY (Codigo_Dominio),
	FOREIGN KEY (Codigo_Dominio) 	
		  REFERENCES SQLfi_Dominio (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Dominio_Fecha (
	Codigo_Dominio INTEGER NOT NULL,
	Dominio VARCHAR(10) NOT NULL CHECK(Dominio IN ('DATE', 'DATE_DAY', 'DATE_MONTH', 'DATE_YEAR')),
	PRIMARY KEY (Codigo_Dominio),
	FOREIGN KEY (Codigo_Dominio) 	
		  REFERENCES SQLfi_Dominio (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Dominio_Hora (
	Codigo_Dominio INTEGER NOT NULL,
	Dominio VARCHAR(10) NOT NULL CHECK(Dominio IN ('TIMESTAMP')),
	PRIMARY KEY (Codigo_Dominio),
	FOREIGN KEY (Codigo_Dominio) 	
		  REFERENCES SQLfi_Dominio (Codigo_Termino) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-------------------------	RELACION DIFUSA		--------------------------------
----------------------------------------------------------------------------------------
CREATE TABLE SQLfi_Relacion_Difusa (
	Codigo_Termino INTEGER NOT NULL,
	Tipo INTEGER NOT NULL CHECK (Tipo IN (0,1)), 
										-- 0 = Escalar 
										-- 1 = Numerica
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Relacion_Escalar (
	Codigo_Relacion INTEGER NOT NULL,
	Elemento1 VARCHAR(20) NOT NULL,
	Elemento2 VARCHAR(20) NOT NULL,
	Membresia FLOAT NOT NULL CHECK (Membresia >= 0.0 AND Membresia <= 1.0),
	PRIMARY KEY (Codigo_Relacion,Elemento1,Elemento2),
	FOREIGN KEY (Codigo_Relacion) 	
		  REFERENCES SQLfi_Relacion_Difusa (Codigo_Termino) 
		  ON DELETE CASCADE
);

CREATE TABLE SQLfi_Relacion_Num (	
	Codigo_Relacion INTEGER NOT NULL,
	Elemento1 FLOAT NOT NULL,
	Elemento2 FLOAT NOT NULL,
	Membresia FLOAT NOT NULL CHECK (Membresia >= 0.0 AND Membresia <= 1.0),
	PRIMARY KEY (Codigo_Relacion,Elemento1,Elemento2),
	FOREIGN KEY (Codigo_Relacion) 	
		  REFERENCES SQLfi_Relacion_Difusa (Codigo_Termino) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
-----------------------		TABLA DIFUSA		-------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Restriccion (
	Codigo SERIAL UNIQUE,
	Codigo_Termino INTEGER NOT NULL,
	SentenciaCheck VARCHAR(256) NOT NULL,
	Membresia FLOAT NOT NULL CHECK (Membresia >= 0.0 AND Membresia <= 1.0),
	PRIMARY KEY (Codigo,Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

----------------------------------------------------------------------------------------
----------------------		VISTA DIFUSA		--------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE SQLfi_Vista_Difusa (
	Codigo_Termino INTEGER NOT NULL,
	SubConsulta VARCHAR(512) NOT NULL,
	Membresia FLOAT NOT NULL, 
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);

---------------------------------------------------------------------------------------
-----------------------		ASERCION DIFUSA		-------------------------------
---------------------------------------------------------------------------------------	

CREATE TABLE SQLfi_Asercion_Difusa (
	Codigo_Termino INTEGER NOT NULL,
	Condicion VARCHAR(256) NOT NULL,
	Membresia FLOAT NOT NULL CHECK (Membresia >= 0.0 AND Membresia <= 1.0),
	PRIMARY KEY (Codigo_Termino),
	FOREIGN KEY (Codigo_Termino) 	
		  REFERENCES SQLfi_Termino_Difuso (Codigo) 
		  ON DELETE CASCADE
);