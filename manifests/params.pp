# aide::params sets the default values for parameters.
class aide::params {
  $package          = 'aide'
  $version          = latest
  $db_path          = '/var/lib/aide/aide.db'
  $db_temp_path     = '/var/lib/aide/aide.db.new'
  $hour             = 3
  $minite           = 0
  $email            = 'root@localhost'

  case $::osfamily {
    'Debian': {
      $aide_path = '/usr/bin/aide'
      $conf_path = '/etc/aide/aide.conf'
      $mail_path = '/usr/bin/mail'
    }
    'Redhat': {
      $aide_path = '/usr/sbin/aide'
      $conf_path = '/etc/aide.conf'
      $mail_path = '/bin/mail'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  $command          = "${::aide::params::aide_path}"
  $check_parameters = "--config=${conf_path}"

}
