# class managing aide configuration.
class aide::config inherits aide {
  concat { 'aide.conf':
    path    => $::aide::conf_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Package['aide']
  }

  concat::fragment { 'aide.conf.header':
    target  => 'aide.conf',
    order   => 01,
    content => template( 'aide/aide.conf.erb')
  }

  concat::fragment { 'rule_header':
    target  => 'aide.conf',
    order   => '02',
    content => "# User defined rules\n",
  }

  concat::fragment { 'watch_header':
    target  => 'aide.conf',
    order   => '49',
    content => "\n# Files and directories to scan\n",
  }

}
