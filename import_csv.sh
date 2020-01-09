<!-- #======================================================# -->

<!-- #IMPORT CSV -->

#!/bin/bash
# sh /path/scripts/import_csv.sh ${TBL_NAME} >> import.log 2>&1
DB_NAME=""
DIR="/data/merge/${DB_NAME}"
mkdir -p ${DIR}
chown -R mysql.mysql ${DIR}
TBL_NAME=$1
DB_HOST="localhost"
DB_USER=""
DB_PASS=""

Q="select count(*) from ${DB_NAME}.${TBL_NAME}"
TR_MYSQL_BF_INSERT=$(mysql --max_allowed_packet=2048M -h${DB_HOST} -u${DB_USER} -p${DB_PASS} -Bse "${Q}")
if [ -f ${DIR}/${TBL_NAME}.csv ]; then
TR_CSV_FILE=$(cat ${DIR}/${TBL_NAME}.csv | wc -l)
fi



mysql --max_allowed_packet=2048M -h${DB_HOST} -u${DB_USER} -p${DB_PASS} -Bs -e "SET GLOBAL bulk_insert_buffer_size=1024 * 1024 * 512; LOAD DATA LOCAL INFILE '${DIR}/${TBL_NAME}.csv' IGNORE INTO TABLE ${DB_NAME}.${TBL_NAME} FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n'"

Q="select count(*) from ${DB_NAME}.${TBL_NAME}"
TR_MYSQL_AT_INSERT=$(mysql --max_allowed_packet=2048M -h${DB_HOST} -u${DB_USER} -p${DB_PASS} -Bse "${Q}")

echo "TOTAL RECORD TABLE ${DB_NAME}.${TBL_NAME} BF_INSERT : ${TR_MYSQL_BF_INSERT}, TR_CSV_FILE : ${TR_CSV_FILE}, TR_MYSQL_AT_INSERT = ${TR_MYSQL_AT_INSERT}"

echo "DONE"
