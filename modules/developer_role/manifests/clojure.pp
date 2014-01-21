class developer_role::clojure {
  include wget

  wget::fetch {'https://raw.github.com/technomancy/leiningen/stable/bin/lein':,
  destination => "$user_home/bin/lein",
  require => File["$user_home/bin"],
  verbose => true,
  execuser => $user_name,
  }~>
  file { "$user_home/bin/lein" : #just changes permition. Is there other way?
    mode => 0777,
    owner => $user_name,
  }

}