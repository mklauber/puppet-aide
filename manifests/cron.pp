# Class for managing aide's cron job.
class aide::cron inherits aide {
  cron { 'aide':
    command => "${aide::command} --check ${aide::check_parameters} > /var/lib/aide/lastrun",
#    command => "${aide::command} --check ${aide::check_parameters} | ${aide::mail_path} -s \"\$HOSTNAME - Daily AIDE integrity check\" ${aide::email}",
#    command => $::aide::command,
    user    => 'root',
    hour    => $::aide::hour,
    minute  => $::aide::minute,
    require => [Package['aide'], Exec['install aide db']]
  }
}
