Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }



node default {

	class { 'consul':
		config_hash => {
			'datacenter'       => 'dc1',
			'data_dir'         => '/opt/consul',
			'ui_dir'           => '/opt/consul/ui',
			'client_addr'      => '0.0.0.0',
			'log_level'        => 'INFO',
			'node_name'        => $::hostname,
			'bind_addr'        => $::ipaddress_eth1,
			'bootstrap_expect' => 1,
			'server'           => true,
		}
	}

  class { '::mysql::server':
    root_password           => 'root',
    remove_default_accounts => true,
    #  override_options        => $override_options
  }



	consul::service { mysql
		port           => 3306,
		check_interval => '5s',
	}

}
