<!-- #DUMP TO CSV -->

#!/bin/bash
# sh /path/scripts/dump_csv.sh ${TBL_NAME} >> dump.log 2>&1
DB_NAME=""
DIR="/data/merge/${DB_NAME}"
mkdir -p ${DIR}
chown -R mysql.mysql ${DIR}
TBL_NAME=$1
DB_HOST="localhost"
DB_USER=""
DB_PASS=""

rm -rf ${DIR}/${TBL_NAME}.csv

QUERY="select * from ${DB_NAME}.${TBL_NAME}  INTO OUTFILE '${DIR}/${TBL_NAME}.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n'"
echo "EXEC QUERY ${QUERY}\n"
mysql --max_allowed_packet=2048M -h${DB_HOST} -u${DB_USER} -p${DB_PASS} -e "${QUERY}"
logger "DONE"
echo "DONE"
