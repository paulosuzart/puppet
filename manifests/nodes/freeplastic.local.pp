node 'freeplastic.local' {
  $user_full_name = extlookup(user_full_name)
  $user_email     = extlookup(user_email)
  $user_name      = extlookup(user_name)
  $user_home      = extlookup(user_home)
  $workspace      = "$user_home/workspace"

  class { 'convenience' :
    setup_ssh_rsa => true,
  }

  include desktop
  include 'docker'

  include haproxy
  
  haproxy::frontend { 'ft_mta' :
    bind            => '127.0.0.1:25',
    default_backend => 'be_smtp1',
    
  }

  haproxy::backend { 'be_smtp1' :
    servers => [{bind   => 'localhost:8025',
                 weight => 20},
                {bind   => 'localhost:8027',
                 weight  => 37}
               ],

  }
  include haproxy::service



  class {'developer_role':
    git           => true,
    change_prompt => true,
    postgis       => false,
    lein          => true,
    postgres      => true,
    gvm           => true,
    pg_databases  => {
                    'dashboard'       => {owner    => 'dashboard',
                                          password => extlookup('pg_dashboard_password')},
                    'configs'         => {owner => 'dashboard',
                                          password => extlookup('pg_dashboard_password')},
    },
    python_virtualenvs => {"$workspace/ENV" => {packages => ['setuptools', 'fabric','python-simple-hipchat',]}},
    gvm_packages       => {
      	                   #groovy versions
                           'groovy'  => {version     => '1.8.8',
                                         is_default  => true,
                                         owner       => $user_name},
                           #grails versions
                           'grails'  => {version     => '1.3.7',
                                         owner       => $user_name},
                           'grails'  => {version     => '2.1.5',
                                         is_default  => true,
                                         owner       => $user_name},
                           #additional packages
                           'vertx'   => {version     => '2.0.2-final',
                                         is_default  =>  true,
                                         owner       => $user_name}
                          },
  }

}
