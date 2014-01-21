class developer_role::gvm () {
   #TODO, should require java somehow
   $gvm_init = "source $user_home/.gvm/bin/gvm-init.sh"
    wget::fetch {'http://get.gvmtool.net':,
      destination => "/tmp/gvm-install.sh",
      verbose     => true,
      execuser    => $user_name,
      user        => $user_name,
    } ~>
    exec { 'GVM' :
      user        => $user_name,
      environment => "HOME=$user_home",
      path        => "/usr/bin:/usr/sbin:/bin",
      command     => "bash gvm-install.sh",
      cwd         => '/tmp',
      logoutput   => true,
      onlyif      => 'echo $PATH |grep -c gvm' #this is a weak test to prevent gvm to always run
    } ~>
    file {"$user_home/.gvm/etc/config" :
      owner  => "$user_name",
      source => "puppet:///modules/developer_role/gvm_config"
    }
   
}