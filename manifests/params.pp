class aide::params {
  $package = 'aide'
  $version = latest
  $db_path = '/var/lib/aide/aide.db.gz'
  $db_temp_path = '/var/lib/aide/aide.db.new'
  $hour    = 0

  $aide_path = $operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => '/usr/bin/aide',
    default                 => '/usr/sbin/aide'
  }
  $conf_path = $operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => '/etc/aide/aide.conf',
    default                 => '/etc/aide.conf'
  }
}