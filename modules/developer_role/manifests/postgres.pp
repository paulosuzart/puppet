class developer_role::postgres ($postgres_password = 'postgres') {

    class { 'postgresql::globals':
      manage_package_repo => true,
    }->
    class { 'postgresql::server':
      listen_addresses           => '*',
      postgres_password          => $postgres_password,
    }


}