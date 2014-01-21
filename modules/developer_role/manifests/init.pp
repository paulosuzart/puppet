# Main developer role. See README.md
class developer_role (
  $postgres           = false,
  $postgis            = false,
  $git                = false,
  $gvm                = false, 
  $lein               = false,
  $pg_databases       = {},
  $change_prompt      = false,
  $python_virtualenvs = undef,
  $gvm_packages       = undef
  ) {
 
  include developer_role::devpackages
  

  file {"$user_home/bin":
    ensure => directory,
    owner => $user_name,
  }

  if ($git) {
    include git
  }

  if ($lein) {
    include developer_role::clojure
  }

  if ($change_prompt) {
    include developer_role::change_prompt
  }

  if ($postgres) {
    class { 'developer_role::postgres':}
    # create all pg databases
    create_resources(developer_role::postgres::create_db, $pg_databases)

    if ($postgis) {
      class { 'developer_role::postgis' :
        require => Class['postgresql::server'],
      }
    }
 
  }
  # installs python by default
  class { 'python':
    version    => 'system',
    dev        => true,
    virtualenv => true,
    gunicorn   => false,
  }

  if ($python_virtualenvs != undef) {
    create_resources(developer_role::python::python_virtualenv, $python_virtualenvs)
  }

  if $gvm {
    class { 'gvm' :
      owner => $user_name,
    }

    if $gvm_packages != undef {
      create_resources(gvm::package, $gvm_packages)
    }
  }

}
