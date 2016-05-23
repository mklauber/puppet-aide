# Class for managing aide's cron job.
class aide::cron inherits aide {
  cron { 'aide':
    command => "${::aide::params::aide_path} --check",
    user    => 'root',
    hour    => '*',
    minute  => $::aide::minute,
    require => [Package['aide'], Exec['install aide db']]
  }
}
