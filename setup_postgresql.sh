#!/bin/sh

echo "Setting up PostgreSQL database"

initdb /usr/local/var/postgres -E utf8
createuser -dsr chembl

# Backup postgresql.conf
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
cp "/usr/local/var/postgres/postgresql.conf" "/usr/local/var/postgres/postgresql.conf-$NOW"

# Update shared_buffers and work_mem in postgresql.conf
sed -i '' "s/^#*shared_buffers \=.*/shared_buffers = 1024MB/" "/usr/local/var/postgres/postgresql.conf"
sed -i '' "s/^#*work_mem \=.*/work_mem = 128MB/" "/usr/local/var/postgres/postgresql.conf"
