#!/bin/bash

psql --command "\i DeployDB.sql"
psql -U sqlfi -d sqlfi_leonid --command "\i catalogo_crear.sql"
psql -U sqlfi -d sqlfi_leonid --command "\i catalogo_cargar.sql"
psql -U sqlfi_app -d sqlfi_leonid_app --command "\i eoeCreate.sql"

for i in `ls eoeLoad*.sql`
do
psql -U sqlfi_app -d sqlfi_leonid_app --command "\i $i"
done