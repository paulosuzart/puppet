# == Define: developer_role::gvm::gvm_packages
#
# Setups GVM packages and set their

# === Parameters
#
# [*owner*]
# The user that owns the database
#
# [*password*]
#
# Database password
#
# Example usage
#
# gvm_packages       => {
#                           'groovy'  => {versions     => ['1.8.8'],
#                                         use_default  => '1.8.8'},
#                           'grails'  => {versions     => ['1.3.7', '2.1.5'],
#                                         use_default  => '2.1.5'},
#                          },

define developer_role::gvm::gvm_package ($version, $is_default = false) {

  $gvm_init = "source $user_home/.gvm/bin/gvm-init.sh"
  exec { $name :
  	environment  => "HOME=$user_home",
    command      => "bash -c '$gvm_init && gvm install $name $version'",
    unless       => "test -d $user_home/.gvm/$name/$version",
    user         => $user_name,
    require      => Exec['GVM'],
    path         => "/usr/bin:/usr/sbin:/bin",
    logoutput    => true
  }
  
  if $is_default {
  	exec {"gvm default $name" :
  	  environment => "HOME=$user_home",
  	  command     => "bash -c '$gvm_init && gvm default $name $version'",
  	  user        => $user_name,
  	  path        => "/usr/bin:/usr/sbin:/bin",
  	  subscribe   => Exec["$name"],
  	  logoutput   => true,
  	}
  }
    
}

