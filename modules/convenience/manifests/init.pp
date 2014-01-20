class convenience ($setup_ssh_rsa = false) {
  package {'vim-gtk':
    ensure => latest,
  }

  package { "htop":
    ensure => latest,
  }

  package { "wget" :
    ensure => latest,
  }

  package { ['curl', 'sed', 'openssh-server', 'openssh-client'] :
    ensure => present,
  }

  package { "nfs-common":
    ensure => installed,
  }

  if $setup_ssh_rsa {
    file { "$user_home/.ssh/id_rsa" :
      ensure  => file
      mode    => 644,
      owner   => $user_name,
      content => extlookup('ssh_private_key_rsa'),
      require => [Package['openssh-server'], Package['openssh-client']]
    }

    file { "$user_home/.ssh/id_rsa.pub" :
      ensure  => file,
      mode    => 600,
      owner   => $user_name,
      content => extlookup('ssh_public_key_rsa')
      require => [Package['openssh-server'], Package['openssh-client']]
    }
  }
}