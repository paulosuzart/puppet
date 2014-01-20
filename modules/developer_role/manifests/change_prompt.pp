class developer_role::change_prompt {
  $prompt_file = '.git_svn_bash_prompt'

  file {"$user_home/$prompt_file" :
    owner => $::user_name,
    source => "puppet:///modules/developer_role/git_svn_bash_prompt",
  }

  exec { 'barshrc entry' :
    command => "echo \". $user_home/$prompt_file\" >> $user_home/.bashrc",
    onlyif =>  ["test `grep $prompt_file $user_home/.bashrc | wc -l` -eq 0"],
    path   => "/usr/bin:/usr/sbin:/bin",
    subscribe => File["$user_home/$prompt_file"],
  }~>

  file {"$user_home/.bashrc":
    owner => $user_name,
  }
}