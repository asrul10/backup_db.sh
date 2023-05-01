#!/usr/bin/env bash

# set your database credentials here
username="username"
password="password"
database="database"
db_dump_prefix="db_dump"
bucket_name="bucket_name"

now=$(date +%F-%H:%M)
db_name="${db_dump_prefix}_${now}.sql.gz"
mysqldump -u ${username} ${database} -p"${password}" --no-tablespaces | gzip > "$db_name"
aws s3 cp "$db_name" "s3://${bucket_name}/${db_name}"
rm "$db_name"
