class haproxy (
	$maxcon = 8192,
	$daemon = true
) {

  package { "haproxy":
  	ensure => installed,
  }

  $config_file = '/etc/haproxy/haproxy.cfg'

  define frontend($bind = '', $mode = 'tcp', $option = 'tcplog', $default_backend) {
  	concat::fragment { "ft_$name" :
  	  target  => $haproxy::config_file,
  	  content => template('haproxy/frontend.erb'),
    }
  }

  define backend($mode = 'tcp', $option = 'tcplog', $servers) {
    concat::fragment { "be_$name" :
      target  => $haproxy::config_file,
      content => template('haproxy/backend.erb'),
    }
  }

  group { 'haproxy':
    ensure => present    
  } 

  user { 'haproxy' :
    ensure  => present,
    groups  => ['haproxy'],
    require => Group['haproxy']
  }

  file { '/etc/haproxy' :
    ensure => directory,
    content => template('haproxy/global.erb')
  }
  
  concat { $config_file :
  	ensure_newline => true,
  }

  concat::fragment { 'global_defaults' :
    target   => $config_file,
    content  => template('haproxy/global.erb'),
  }
}