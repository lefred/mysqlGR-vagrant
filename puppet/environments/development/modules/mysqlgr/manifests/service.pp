class mysqlgr::service ($ensure="running", $bootstrap=False) {
        
  if ($bootstrap == True)   {
    info("we will have too bootstrap this member")	
  }

  service {
	"mysqld":
		enable  => true,
            	ensure  => $ensure,
		subscribe => File['my.cnf'],
            	require => [ Package['mysql-community-server'], Exec['initialize_mysql'], Service['firewalld'] ];
	"firewalld":
		enable  => false,
		ensure  => stopped,
  }
}
