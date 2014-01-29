class haproxy::service {
  	service { 'haproxy' :
  	  ensure  => running,
  	  require => Class['haproxy']
    }

}