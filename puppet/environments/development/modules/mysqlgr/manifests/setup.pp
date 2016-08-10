class mysqlgr::setup {

 $bootstrap = $mysqlgr::bootstrap
 $gr_user   = $mysqlgr::gr_user
 $gr_password = $mysqlgr::gr_password

 if $bootstrap {
    	info("We will bootstrap............ !!")
        $cmd1 = "CREATE USER '$gr_user'@'%' IDENTIFIED BY '$gr_password'; GRANT REPLICATION SLAVE ON *.* TO '$gr_user'@'%';" 
        $cmd2 = "SET GLOBAL group_replication_bootstrap_group=ON; START GROUP_REPLICATION; SET GLOBAL group_replication_bootstrap_group=OFF;"
 } else {
        $cmd1 = ""
	$cmd2 = "SET GLOBAL group_replication_allow_local_disjoint_gtids_join=1; START GROUP_REPLICATION;"
 }

 exec { 
	'install_gr_plugin':
		command   => "mysql --defaults-file=/root/.my.cnf -BN -e \"INSTALL PLUGIN group_replication SONAME 'group_replication.so';\"",
		unless    => "mysql --defaults-file=/root/.my.cnf -BN -e 'show plugins' | grep -i group_replication > /dev/null",
		path      => [ '/bin' ],
		require   => Service['mysqld'];
 	'add_gr_master_user':
		command   => "mysql --defaults-file=/root/.my.cnf -BN -e \"CHANGE MASTER TO MASTER_USER='$gr_user', MASTER_PASSWORD='$gr_password' FOR CHANNEL 'group_replication_recovery'; $cmd1 \"",
		unless    => "mysql --defaults-file=/root/.my.cnf -BN -e 'select user from mysql.user where user = \"$gr_user\"' | grep $gr_user > /dev/null",
		path      => [ '/bin' ],
		require   => Exec['install_gr_plugin'];
        'start_gr':
		command   => "mysql --defaults-file=/root/.my.cnf -BN -e \"$cmd2\"",
		path      => [ '/bin' ],
		unless	  => "mysql --defaults-file=/root/.my.cnf -BN -e 'select MEMBER_HOST, MEMBER_STATE from performance_schema.replication_group_members where MEMBER_HOST = \"$hostname\"' | grep -i $hostname",
		require   => Exec['add_gr_master_user'];

 }

	
}
