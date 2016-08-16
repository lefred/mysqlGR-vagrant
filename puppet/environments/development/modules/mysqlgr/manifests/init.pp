class mysqlgr (
	$mysql_root_password=undef,
	$mysql_old_root_password=undef,
	$mysql_serverid=undef, 
	$ensure="running", 
	$bootstrap=false, 
	$mysql_bind_interface="eth0", 
	$group_name="afb80f36-2bff-11e6-84e0-0800277dd3bf", 
	$group_seeds=undef, $gr_user="gr_repl", 
	$gr_password="gr_passwd",
    $use_ssl=false ) {
        
        info("Welcome in MySQL Group Replication experience !")

        $mysql_ip = inline_template("<%= scope.lookupvar('ipaddress_${mysql_bind_interface}') -%>")
        info("Interface to use = $mysql_bind_interface and has IP $mysql_ip")

        if ($use_ssl)
        {
            info("You will use SSL for GR")
        }

        include mysqlgr::packages 
        include mysqlgr::config
        include mysqlgr::service
        include mysqlgr::setup
}
