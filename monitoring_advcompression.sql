SELECT SUBSTR(OBJECT_NAME, 1, 20),
       SUBSTR(SUBOBJECT_NAME, 1, 20),
       TRACK_TIME,
       SEGMENT_WRITE,
       FULL_SCAN,
       LOOKUP_SCAN
  FROM V$HEAT_MAP_SEGMENT;

SELECT SUBSTR(OBJECT_NAME, 1, 20),
       SUBSTR(SUBOBJECT_NAME, 1, 20),
       SEGMENT_WRITE_TIME,
       SEGMENT_READ_TIME,
       FULL_SCAN,
       LOOKUP_SCAN
  FROM DBA_HEAT_MAP_SEGMENT;

SELECT SUBSTR(OBJECT_NAME, 1, 20),
       SUBSTR(SUBOBJECT_NAME, 1, 20),
       TRACK_TIME,
       SEGMENT_WRITE,
       FULL_SCAN,
       LOOKUP_SCAN
  FROM DBA_HEAT_MAP_SEG_HISTOGRAM;

SELECT SUBSTR(OWNER, 1, 20),
       SUBSTR(OBJECT_NAME, 1, 20),
       OBJECT_TYPE,
       SUBSTR(TABLESPACE_NAME, 1, 20),
       SEGMENT_COUNT
  FROM DBA_HEATMAP_TOP_OBJECTS
 ORDER BY SEGMENT_COUNT DESC;

SELECT SUBSTR(TABLESPACE_NAME, 1, 20), SEGMENT_COUNT
  FROM DBA_HEATMAP_TOP_TABLESPACES
 ORDER BY SEGMENT_COUNT DESC;

SELECT COUNT(*) FROM DBA_HEATMAP_TOP_OBJECTS;

SELECT COUNT(*) FROM DBA_HEATMAP_TOP_TABLESPACES;
