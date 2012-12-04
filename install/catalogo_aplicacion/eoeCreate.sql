
CREATE TABLE asignatura (
    codigo varchar(8) NOT NULL,
    nombre varchar(256) NOT NULL
);


create table comentario ( 
    id_comentario integer not null, 
	id_prof_encuesta integer not null, 
	id_grupo integer not null, 
	id_pregunta integer not null, 
	comentario varchar(2000) not null
);


CREATE TABLE cursa (
    codigo varchar(8) NOT NULL,
    seccion integer NOT NULL,
    id_periodo integer NOT NULL,
    id_student varchar(256) NOT NULL
);


CREATE TABLE encuesta (
    id_encuesta integer NOT NULL,
    descripcion varchar(300),
    "owner" varchar(256) NOT NULL,
    tipo varchar(256)
);


CREATE TABLE encuesta_grupo (
    id_encuesta integer NOT NULL,
    id_grupo integer NOT NULL,
    numero integer DEFAULT 0 NOT NULL,
    ponderacion integer DEFAULT 0 NOT NULL,
    visible_estudiantes Char(1) Default 'Y' Not Null Check (visible_estudiantes In ('Y','N')),
    visible_otros Char(1) Default 'Y' Not Null Check (visible_otros In ('Y','N'))
);


CREATE TABLE encuesta_periodo (
    id_encuesta integer NOT NULL,
    id_periodo integer NOT NULL,
    fecha_inicio date,
    fecha_cierre date,
    fecha_opinion date
);


CREATE TABLE estadistica (
    fecha date NOT NULL,
    act_encuestas integer NOT NULL,
    act_estudiantes integer NOT NULL,
    act_asignaturas integer NOT NULL,
    total_encuestas integer NOT NULL,
    total_estudiantes integer NOT NULL,
    total_asignaturas integer NOT NULL
);


CREATE TABLE grupo (
    id_grupo integer NOT NULL,
    "owner" varchar(256) NOT NULL,
    nombre varchar(256)
);


CREATE TABLE grupo_extra (
    id_grupo integer NOT NULL,
    id_prof_encuesta integer NOT NULL
);


CREATE TABLE grupo_pregunta (
    id_grupo integer NOT NULL,
    id_pregunta integer NOT NULL,
    numero integer DEFAULT 0 NOT NULL,
    ponderacion integer DEFAULT 0 NOT NULL,
    comentario Char(1) Default 'N' Not Null Check (comentario In ('Y','N'))
);


CREATE TABLE historial (
    id_prof_encuesta integer NOT NULL,
    id_grupo integer NOT NULL,
    id_pregunta integer NOT NULL,
    id_respuesta integer NOT NULL,
    o_inscritos integer DEFAULT 0 NOT NULL,
    o_foraneos integer DEFAULT 0 NOT NULL,
    o_papel integer DEFAULT 0 NOT NULL
);


CREATE TABLE noticia (
    id_noticia integer NOT NULL,
    id_parent integer,
    fecha_inicio timestamp NOT NULL,
    fecha_caducidad timestamp,
    fecha_eliminacion timestamp,
    "owner" varchar(256) NOT NULL,
    titulo varchar(256),
    cuerpo varchar(256)
);


CREATE TABLE oferta (
    codigo varchar(8) NOT NULL,
    seccion integer NOT NULL,
    id_periodo integer NOT NULL
);


CREATE TABLE opinante (
    id_prof_encuesta integer NOT NULL,
    id_student varchar(8) NOT NULL
);


CREATE TABLE periodo (
    id_periodo integer NOT NULL,
    anio integer NOT NULL,
    periodo integer NOT NULL
);

CREATE TABLE pregunta (
    id_pregunta integer NOT NULL,
    "owner" varchar(256) NOT NULL,
    enunciado varchar(300) NOT NULL
);


CREATE TABLE pregunta_respuesta (
    id_pregunta integer NOT NULL,
    id_respuesta integer NOT NULL,
    valor smallint DEFAULT 0 NOT NULL,
    descripcion varchar(300)
);


CREATE TABLE profesor (
    cedula integer NOT NULL,
    nombre varchar(256) NOT NULL
);


CREATE TABLE profesor_encuesta (
    id_prof_encuesta integer NOT NULL,
    id_periodo integer NOT NULL,
    id_encuesta integer NOT NULL,
    codigo varchar(8) NOT NULL,
    seccion integer NOT NULL,
    prof_cedula integer NOT NULL,
   nro_estudiantes integer DEFAULT 0 NOT NULL
);

CREATE TABLE respuesta (
    id_respuesta integer NOT NULL,
    "owner" varchar(256) NOT NULL,
    opcion varchar(256) NOT NULL
);




CREATE TABLE unidad (
    id_unidad integer NOT NULL,
    usbid varchar(256),
    nombre varchar(256) NOT NULL,
    mostrar Char(1) Default 'Y' Not Null Check (mostrar In ('Y','N'))
);


CREATE TABLE unidad_asignatura (
    id_unidad integer NOT NULL,
    codigo varchar(8) NOT NULL
);

