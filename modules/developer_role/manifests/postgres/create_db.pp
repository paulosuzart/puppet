# == Define: developer_role::postgres::create_db
#
# Simpliy wraps postgresql::server::db to a more simple and plaing hasg structure

# === Parameters
#
# [*owner*]
# The user that owns the database
#
# [*password*]
#
# Database password
#
# Example usage
#
#pg_databases  => {
#	              'portal_2011'     => {owner    => 'portal', 
#	                                    password => 'portal'}, 
#                  'dashboard'       => {owner    => 'dashboard',
#                                        password => 'dashboard'},
#                  'datamining_2011' => {owner => 'datamining',
#                                       password => 'datamining'},
#},

define developer_role::postgres::create_db ($owner, $password) {

  postgresql::server::db { $name :
    user     => $owner,
    password => postgresql_password($owner, $password),
    require => Class['postgresql::server'],
  }
}

