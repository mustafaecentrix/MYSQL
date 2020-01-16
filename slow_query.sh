#SLOW QUERY
0 1 * * * sh /home/app/bin/scripts/slow_query.sh > /dev/null

#!/bin/bash
TGL=$(date --date=' 0 days ago' '+%Y%m%d')
LOG_FILE="/home/app/log/slow_query/FINDB_SLOW.log"
chown -R mysql.mysql ${LOG_FILE}
if [ -f $LOG_FILE ]; then
zip -r ${LOG_FILE}_${TGL}.zip ${LOG_FILE}
fi
echo > ${LOG_FILE}
mysql -e "SET GLOBAL slow_query_log = 'ON';"
mysql -e "SET GLOBAL long_query_time = 10;"
mysql -e "SET GLOBAL slow_query_log_file = '${LOG_FILE}'"
mysql -e "SET GLOBAL log_queries_not_using_indexes = 'ON';"
echo "DONE"
