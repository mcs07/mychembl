#!/bin/sh

echo "Setting up PostgreSQL database"
initdb /usr/local/var/postgres -E utf8
# Backup postgresql.conf
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
cp "/usr/local/var/postgres/postgresql.conf" "/usr/local/var/postgres/postgresql.conf-$NOW"
# Update shared_buffers and work_mem in postgresql.conf
sed -i '' "s/^#*shared_buffers \=.*/shared_buffers = 1024MB/" "/usr/local/var/postgres/postgresql.conf"
sed -i '' "s/^#*work_mem \=.*/work_mem = 128MB/" "/usr/local/var/postgres/postgresql.conf"

echo "Dowloading ChEMBL database"
cd ~/mychembl
wget -N ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_18/chembl_18_postgresql.tar.gz
tar -zxf chembl_18_postgresql.tar.gz

echo "Importing ChEMBL into PostgreSQL"
pg_ctl -w -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
createdb chembl_18
psql chembl_18 < chembl_18_postgresql/chembl_18.pgdump.sql
rm -r chembl_18_postgresql
psql -d chembl_18 -c "create extension rdkit;"
wget https://raw.githubusercontent.com/chembl/mychembl/master/indexes.sql
psql -d chembl_18 -a -f indexes.sql
rm indexes.sql
wget https://raw.githubusercontent.com/chembl/mychembl_webapp/master/sql/webapp.sql
psql -d chembl_18 -a -f webapp.sql
rm webapp.sql
psql -d chembl_18 -c "create user mychembl password 'read';"
psql -d chembl_18 -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO mychembl;"
