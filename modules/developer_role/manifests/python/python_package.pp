# Define: python_pages
# Parameters: $virtualenv
# arguments
#
define developer_role::python::python_package ($virtualenv)  {
  
  python::pip {$name :
    virtualenv => $virtualenv,
    require    => Class['python'],
    ensure     => present,
  }
}
