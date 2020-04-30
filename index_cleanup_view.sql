select i.obj#, i.flags, u.name, o.name, o.type#  
  from sys.obj$ o, sys.user$ u, sys.ind$ idx, sys.ind_online$ i
  where  bitand(i.flags, 512) = 512 and o.obj#=idx.obj# and
          o.owner# = u.user# and idx.obj#=i.obj#;
