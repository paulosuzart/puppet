class convenience {
  package {'vim-gtk':
    ensure => latest,
  }

  package { "htop":
    ensure => latest,
  }

  package { "wget" :
    ensure => latest,
  }

  package { ['curl', 'sed'] :
    ensure => present,
  }

  package { "nfs-common":
    ensure => installed,
  }  
}