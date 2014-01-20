class base {  

  package { 'vim-gtk' :
    ensure => latest,
  }

  package {'htop' :
    ensure => latest
  }

  package {'ack-grep' :
   ensure => latest,
  }

}
