SELECT table_name AS 'Table',FORMAT(table_rows,0) AS 'Quant of Rows',FORMAT(
round(((data_length + index_length) / 1024 / 1024), 0),0) 'Size in MB' FROM
 information_schema.TABLES WHERE table_schema = '${DB_NAME}' 
AND TABLE_NAME IN ('table1','table2')
ORDER BY (data_length + index_length) DESC;
