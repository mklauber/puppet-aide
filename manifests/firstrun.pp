# the aide::firstrun class creates the database that will be used for future checks.
class aide::firstrun inherits aide {
  exec { 'aide init':
    command     => "${::aide::params::aide_path} --init --config ${::aide::conf_path}",
    user        => 'root',
    refreshonly => true,
    timeout     => 0,
    subscribe   => Concat['aide.conf']
  }

  exec { 'install aide db':
    command     => "/bin/cp -f ${::aide::db_temp_path} ${::aide::db_path}",
    user        => 'root',
    refreshonly => true,
    timeout     => 0,
    subscribe   => Exec['aide init']
  }

  file { $::aide::db_path:
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
