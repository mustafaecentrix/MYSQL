DB_NAME=""
TBL_NAME=""
mysqldump --skip-add-drop-table  --skip-comments -d ${DB_NAME} ${TBL_NAME} |egrep -v "(^SET|^/\*\!)" |sed "s/AUTO_INCREMENT=[0-9]*//g" > /tmp/filename.sql
echo "DONE"


Example output :
CREATE TABLE `acs_agent_assignment` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `user_id` varchar(32) DEFAULT NULL,
  `team` varchar(32) DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(30) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_idx` (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `team_idx` (`team`),
  KEY `created_by_idx` (`created_by`),
  KEY `created_time_idx` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
