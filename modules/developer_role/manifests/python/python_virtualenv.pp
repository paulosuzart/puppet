# Define: python_virtualenv
# Parameters: $virtualenv
# arguments
#
define developer_role::python::python_virtualenv ($packages, $python_version = 'system') {

  python::virtualenv { $name :
       ensure   => present,
       version  => $python_version,
       owner    => $::user_name,
       require => Class['python']
  }->

  developer_role::python::python_package { $packages: 
    virtualenv => $name,
  }
}
