class mysqlgr::config {

 $root_password = $mysqlgr::mysql_root_password
 $old_root_password = $mysqlgr::mysql_old_root_password

 if $root_password != undef {
   case $old_root_password {
     undef   : { $old_pwd = '' }
     default : { $old_pwd = "-p'${old_root_password}'" }
   }
 }

 exec { 'set_root_pwd':
	command   => "mysqladmin -u root ${old_pwd} password '${root_password}'",
        logoutput => true,
        unless    => "mysqladmin -u root -p'${root_password}' status > /dev/null",
        path      => '/usr/local/sbin:/usr/bin:/usr/local/bin',
        require   => [ Exec['initialize_mysql'], Service['mysqld'] ],
 }
 
 file { '/root/.my.cnf':
     ensure  => present,
     content => template("mysqlgr/rootmy.cnf.erb"),
     require   => Exec['initialize_mysql'],
 }

 $mysqlserverid = $mysqlgr::mysql_serverid

       
 exec {
	"disable-selinux":
       		path    => ["/usr/bin","/bin","/sbin"],
                command => "setenforce 0",
                unless => "getenforce | grep Permissive",
 }

 $my_file="/etc/my.cnf"

 file {
	"my.cnf":
        	path    => $my_file,
                ensure  => present,
                content => template("mysqlgr/my.cnf.erb"),
		require => Package['mysql-community-server']
 }

 exec {
 	"initialize_mysql":
        	path    => ['/sbin', '/usr/bin', '/bin'],
                unless  => "test -f /var/lib/mysql/ibdata1",
                require => Package['mysql-community-server'],
                command => "mysqld --initialize-insecure -u mysql --datadir /var/lib/mysql";
 }


}
