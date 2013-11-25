# the aide class manages some the configuration of aide
class aide (
    $package      = $aide::params::package,
    $version      = $aide::params::version,
    $conf_path    = $aide::params::conf_path,
    $db_path      = $aide::params::db_path,
    $db_temp_path = $aide::params::db_temp_path,
    $hour         = $aide::params::hour
  ) inherits aide::params {

  package { 'aide':
    ensure => $version,
    name   => $package
  }

  exec { 'aide init':
    command     => "${aide::params::aide_path} --init --config ${conf_path}",
    user        => 'root',
    refreshonly => true,
    subscribe   => Concat['aide.conf']
  }

  exec { 'install aide db':
    command     => "/bin/cp -f ${db_temp_path} ${db_path}",
    user        => 'root',
    refreshonly => true,
    subscribe   => Exec['aide init']
  }

  concat { 'aide.conf':
    path    => $conf_path,
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

  cron { 'aide':
    command => "${aide::params::aide_path} --check",
    user    => 'root',
    hour    => $hour,
    require => [Package['aide'], Exec['install aide db']]
  }

  file { $db_path:
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Exec['install aide db']
  }
  file { '/var/lib/aide/aide.db.new.gz':
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Exec['aide init']
  }
}