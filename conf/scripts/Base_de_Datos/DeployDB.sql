CREATE database sqlfi_leonid;
CREATE database sqlfi_leonid_app;
CREATE USER sqlfi WITH PASSWORD 'sqlfi';
CREATE USER sqlfi_app WITH PASSWORD 'sqlfi_app';
GRANT ALL PRIVILEGES ON DATABASE sqlfi_leonid to sqlfi;
GRANT ALL PRIVILEGES ON DATABASE sqlfi_leonid_app to sqlfi_app;



