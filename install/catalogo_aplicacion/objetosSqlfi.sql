-- SE CREAN TIPOS PARA LAS FUNCIONES

DROP TYPE IF EXISTS resultados_m;
DROP TYPE IF EXISTS resultados_p;

CREATE  TYPE resultados_m as (nombre_materia text,cod_materia text, promedio double precision);
CREATE  TYPE resultados_p as (nombre_profesor text,ci_profesor integer, promedio double precision);


-- FUNCION DE MATERIAS

DROP FUNCTION IF EXISTS materia_pregunta(int,int);
CREATE FUNCTION materia_pregunta(int,int) RETURNS SETOF resultados_m
AS 
$$ 
	SELECT  a.nombre ,p.codigo, -- argumento 1 cual tabla
	       ((sum((id_respuesta -2)* o_inscritos))/sum(o_inscritos)::real)
	       as puntuacion
	FROM profesor_encuesta p, historial h, unidad_asignatura u, asignatura a   
	WHERE (id_encuesta=1 or id_encuesta=4) 
	      and (p.id_prof_encuesta = h.id_prof_encuesta)
	      and (u.codigo = p.codigo) 
	      and (p.codigo = a.codigo)
	      and (a.codigo = u.codigo)
	      and id_pregunta=$1 -- argumento 2 cual pregunta
	      and u.id_unidad = $2 -- argumento 3 cual unidad
	GROUP BY p.codigo,a.nombre; --argumento 1
$$
LANGUAGE SQL;

-- FUNCION DE PROFESORES

DROP FUNCTION IF EXISTS profesor_pregunta(int);
CREATE FUNCTION profesor_pregunta(int) RETURNS SETOF resultados_p
AS 
$$ 
	SELECT pr.nombre, p.prof_cedula, 
	       ((sum((id_respuesta -2)* o_inscritos))/sum(o_inscritos)::real)
	       as puntuacion
	FROM profesor_encuesta p, historial h, profesor pr  
	WHERE (id_encuesta=1 or id_encuesta=4) 
	      and (p.id_prof_encuesta = h.id_prof_encuesta) 
	      and id_pregunta=$1
	      and p.prof_cedula=pr.cedula
	GROUP BY p.prof_cedula,pr.nombre; 
$$
LANGUAGE SQL;



-- VISTAS


DROP VIEW IF EXISTS vmat_expectativa;
CREATE VIEW vmat_expectativa AS (
	SELECT *
	FROM materia_pregunta(24,50)		
);

DROP VIEW IF EXISTS vmat_dificultad;
CREATE VIEW vmat_dificultad AS (
	SELECT *
	FROM materia_pregunta(30,50)		
);

DROP VIEW IF EXISTS vmat_utilidad;
CREATE VIEW vmat_utilidad AS (
	SELECT *
	FROM materia_pregunta(26,50)
);

DROP VIEW IF EXISTS vmat_esfuerzo;
CREATE VIEW vmat_esfuerzo AS (
	SELECT *
	FROM materia_pregunta(23,50)
);

DROP VIEW IF EXISTS vmat_preparacion;
CREATE VIEW vmat_preparacion AS (
	SELECT *
	FROM materia_pregunta(22,50)
);

DROP VIEW IF EXISTS vprof_calidad;
CREATE VIEW vprof_calidad AS (
	SELECT *
	FROM profesor_pregunta(20)
);

DROP TABLE IF EXISTS profesor_asignatura;
CREATE TABLE profesor_asignatura AS
(SELECT distinct prof_cedula, codigo
FROM profesor_encuesta);

-- FUNCION MAGICA

DROP FUNCTION IF EXISTS existe_predicado(text);
CREATE FUNCTION existe_predicado(text)
RETURNS integer AS
$$
BEGIN
if EXISTS(SELECT codigo
              FROM sqlfi_termino_difuso
             WHERE identificador = $1)
then			
  return 1;
else
  return 0;
end if;

END;
$$
LANGUAGE plpgsql VOLATILE
