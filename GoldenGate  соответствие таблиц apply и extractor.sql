--FOR ODS --- GG CONF PRM REFRESH
declare
l_dir varchar2(50) := 'GG_DIRPRM';
v_stmt varchar2(1000) default null;
begin
     execute immediate 'truncate table VVOLKOV.GG_PRM_MAP';
     for i in ( select distinct lower(replace(dap.APPLY_NAME,'OGG$')) as rep from dba_apply_parameters dap)
       loop
           --v_stmt := 'vvolkov.read_file_to_clob(''GG_TEMP_PRM'', '''||lower(i.rep)||'.prm'')';
           v_stmt := 'begin vvolkov.load_gg_conf(:a, '''||i.rep||'.prm''); end;';
           execute immediate v_stmt using l_dir;
       end loop;
end;

--VEIW RESULT

select distinct h.extract_name, gpm.srcowner,gpm.srctable,gpm.dstowner,gpm.dsttable,gpm.repname
  from vvolkov.gg_prm_map gpm,
       GGADMIN.HEARTBEAT h
 where  upper(gpm.repname) = h.delgroup
       and gpm.dstowner = 'STAGE04'
      -- and gpm.dsttable like 'SUBS_OPT_DAT%'
   --   and gpm.repname like '%f%'
  --    and gpm.srctable='USI'
  order by 1,2,3,5;
