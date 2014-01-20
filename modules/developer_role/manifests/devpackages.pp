class developer_role::devpackages {

  package { 'meld':
    ensure => latest,
  }

  package { 'kdiff3':
    ensure => latest,
  }

  package { "ack-grep":
  	ensure => installed,
  }

  package { "terminator":
    ensure => latest,
  }

  package { ['libasound2', 'libx11-6', 'libxext6', 'libxi6', 'libxt6', 'libxtst6'] :
    ensure => installed,
  }
}