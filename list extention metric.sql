SELECT ver.name "Metric Extension Name",
       ver.display_name,
       ver.collection_interval "Collection Interval",
       CASE ver.status
         WHEN 0 THEN
          'Deployable Draft'
         WHEN 1 THEN
          'Editable'
         WHEN 2 THEN
          'Published'
       END "Status",
       CASE col.operator
         WHEN 0 THEN
          '>'
         WHEN 1 THEN
          '='
         WHEN 2 THEN
          '<'
         WHEN 3 THEN
          '<='
         WHEN 4 THEN
          '>='
         WHEN 5 THEN
          'CONTAINS'
         WHEN 6 THEN
          '<>'
         WHEN 7 THEN
          'MATCH'
       END "Operator",
       ver.metadata_definition,
       extract(xmltype(ver.metadata_definition),'/Metric/QueryDescriptor/Property[@NAME="STATEMENT"]/text()') "SQL",
       col.column_name,
       col.column_display_name,
       col.warning_threshold "Warning Threshold",
       col.critical_threshold "Critical Threshold",
       col.message,
       col.clear_message
  FROM SYSMAN.EM_MEXT_VERSIONS ver, SYSMAN.EM_MEXT_COLUMNS col, sysman.em_mext_groups mg, sysman.em_mext_target_assoc mt
 WHERE ver.mext_version_id = col.mext_version_id
   AND col.warning_threshold IS NOT NULL
   AND col.critical_threshold IS NOT NULL
   and mg.name=ver.name
   and ver.target_type='oracle_database'
   and mg.metric_group_id=mt.metric_group_id
   and mt.target_guid = '0E606F9477D54C1D6F7C9F696498457E' --DWH_ST_jupiter
 order by ver.name
