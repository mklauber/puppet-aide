# Class for managing aide's cron job.
class aide::cron inherits aide {
  cron { 'aide':
    command => $::aide::command,
    user    => 'root',
    hour    => $::aide::hour,
    minute  => $::aide::minute,
    require => [Package['aide'], Exec['install aide db']]
  }
}
