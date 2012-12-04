#!/bin/bash

echo "INICIANDO INSTALACION DE LA BASE DE DATOS" | tee -a log_instalacion

echo '*:*:*:sqlfi:sqlfi' >> asdvg.tmp
echo '*:*:*:sqlfi_app:sqlfi_app' >> asdvg.tmp

export PGPASSFILE="asdvg.tmp"

echo "CREACION DE LAS BASES DE DATOS INICIALES" | tee -a log_instalacion

psql --command "\i DeployDB.sql" >> log_instalacion

echo "CARGANDO CATALOGO DE SQLFI" | tee -a log_instalacion

psql -U sqlfi -d sqlfi_leonid --command "\i catalogo_sqlfi/catalogo_crear.sql" >> log_instalacion
psql -U sqlfi -d sqlfi_leonid --command "\i catalogo_sqlfi/catalogo_cargar.sql" >> log_instalacion

echo "CARGANDO CATALOGO DE LA APLICACION (ESTO TARDARA VARIAS DECENAS DE MINUTOS)" | tee -a log_instalacion

psql -U sqlfi_app -d sqlfi_leonid_app --command "\i catalogo_aplicacion/eoeCreate.sql" >> log_instalacion

for i in `ls catalogo_aplicacion/eoeLoad*.sql`
do
echo "CARGANDO SCRIPT $i" | tee -a log_instalacion
psql -U sqlfi_app -d sqlfi_leonid_app --command "\i catalogo_aplicacion/$i" >> log_instalacion
done

echo "CARGANDO OBJETOS AUXILIARES DE LA APLICACION"  | tee -a log_instalacion
psql -U sqlfi_app -d sqlfi_leonid_app --command "\i catalogo_aplicacion/objetosSqlfi.sql" >> log_instalacion

export CLASSPATH=.:../lib/db2jcc.jar:../lib/javacc.jar:../lib/jaybird-full-2.1.6.jar:../lib/mysql-connector-java-5.1.2-beta-bin.jar:../lib/ojdbc14.jar:../lib/postgresql-8.3-604.jdbc3.jar:../lib/SQLfiApplication.jar:../lib/sqljdbc4.jar

javac CargarPredicados.java >> log_instalacion

echo "CARGANDO PREDICADOS DIFUSOS" | tee -a log_instalacion
java CargarPredicados >> log_instalacion

rm *.class *.tmp

export CLASSPATH=""
export PGPASSFILE=""

echo "INSTALACION DE BASES DE DATOS TERMINADA" | tee -a log_instalacion