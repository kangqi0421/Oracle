connect TARGET sys/passwd@fprcdev
run {
shutdown immediate
startup mount
backup full database;
alter database open
}
EOF
