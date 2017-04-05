class getridoflocaldomain {

   exec {
      byelocaldomain:
        path    => ['/usr/bin', '/bin'],
        onlyif  => "hostname | grep localdomain",
        command => "hostname $hostname",
        before  => Class['innodbcluster::service'];
   }
}
