class developer_role::git {

  package { 'git-core' : 
    ensure => latest,
  }

  file { "$user_home/.gitconfig" :
    owner => $user_name,
    content => template("developer_role/gitconfig"),
  }

}
