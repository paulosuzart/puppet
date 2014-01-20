node 'freeplastic.local' {
  $user_full_name = 'Paulo Suzart'
  $user_email = 'paulosuzart@gmail.com'
  $user_name = 'suzart'
  $user_home = "/home/$user_name"
  $workspace = "$user_home/workspace"
 
  include convenience
  include desktop
  
  class {'developer_role':
    git           => true,
    change_prompt => true,
    postgis       => false,
    lein          => true,
    postgres      => true,
    gvm           => true,
    pg_databases  => {
                    'dashboard'       => {owner    => 'dashboard',
                                          password => 'dashboard'},
                    'configs'         => {owner => 'dashboard',
                                          password => 'dashboard'},
    },
    python_virtualenvs => {"$workspace/ENV" => {packages => ['setuptools', 'fabric','python-simple-hipchat']}},
    gvm_packages       => {
    	                   #groovy versions
                           'groovy'  => {version     => '1.8.8',
                                         is_default  => true},
                           #grails versions
                           'grails'  => {version     => '1.3.7',},
                           'grails'  => {version     => '2.1.5',
                                         is_default  => true},
                           #additional packages
                           'vertx'   => {version     => '2.0.2-final',
                                         is_default  =>  true}
                          },
  }

}
