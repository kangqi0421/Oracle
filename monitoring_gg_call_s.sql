select count(*)
  from stage05.call_s o
 where gg_op_cmt_time >= to_date('22.07.2016 00:04:00', 'DD-MM-YYYY HH24:MI:SS');
