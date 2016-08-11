hiera_include('classes')

if versioncmp($::puppetversion,'3.6.1') >= 0 {
      $allow_virtual_packages = hiera('allow_virtual_packages',false)
      Package {
        allow_virtual => $allow_virtual_packages,
      }
}


node mysql1 {
}
node mysql2 {
}
node mysql3 {
}
node mysql4 {
}

