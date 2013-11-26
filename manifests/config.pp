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
}