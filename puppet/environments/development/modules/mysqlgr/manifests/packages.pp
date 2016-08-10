class mysqlgr::packages {

        $versionpack = "5.7.14-1.labs_gr080.el7"
        $versiontgz  = "5.7.14-labs-gr080-el7"

	$require = Exec['extract_labs']

        exec {
		get_labs:
			path 	=> ['/usr/bin', '/bin'],
			unless  => "test -f /vagrant/mysql-$versiontgz-$architecture.rpm.tar.gz || rpm -q  mysql-community-server >/dev/null",
                        cwd	=> '/vagrant',
			command	=> "wget http://downloads.mysql.com/snapshots/pb/mysql-group-replication-0.8.0-labs/mysql-$versiontgz-$architecture.rpm.tar.gz";
		extract_labs:
			path 	=> ['/usr/bin', '/bin'],
			unless  => "rpm -q  mysql-community-server",
                        cwd	=> '/vagrant',
			require => Exec['get_labs'],
			command	=> "tar zxvf mysql-$versiontgz-$architecture.rpm.tar.gz";
		swap_packages:
			path 	=> ['/usr/bin', '/bin'],
			onlyif  => "rpm -q  mariadb-libs",
                        cwd	=> '/vagrant',
			require => Exec['extract_labs'],
			command	=> "yum -y swap mariadb-libs mysql-community-libs-$versionpack.$architecture.rpm mysql-community-common-$versionpack.$architecture.rpm mysql-community-libs-compat-$versionpack.$architecture.rpm"
	
			
	}

 	package {
        	   "mysql-community-common":
		      provider => rpm,
		      source => "/vagrant/mysql-community-common-$versionpack.$architecture.rpm",
                      require => Exec['swap_packages'],
                      ensure  => "installed";
                    "mysql-community-libs":
		      provider => rpm,
		      source => "/vagrant/mysql-community-libs-$versionpack.$architecture.rpm",
                      require => [ Exec['swap_packages'], Package['mysql-community-common']],
                      ensure  => "installed";
                    "mysql-community-libs-compat":
		      provider => rpm,
		      source => "/vagrant/mysql-community-libs-compat-$versionpack.$architecture.rpm",
                      require => [ Exec['swap_packages'], Package['mysql-community-libs']],
                      ensure  => "installed";
                    "mysql-community-server":
		      provider => rpm,
		      source => "/vagrant/mysql-community-server-$versionpack.$architecture.rpm",
                      require => [$require, Package['mysql-community-libs'], Package['mysql-community-client'] ],
                      ensure  => "installed";
 		    "mysql-community-client":
		      provider => rpm,
		      source => "/vagrant/mysql-community-client-$versionpack.$architecture.rpm",
                      require => [$require, Package['mysql-community-libs']],
                      ensure  => "installed";
  	}


}
