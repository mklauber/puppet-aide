# aide::params sets the default values for parameters.
class aide::params {
  $package          = 'aide'
  $version          = latest
  $db_path          = '/var/lib/aide/aide.db.gz'
  $db_temp_path     = '/var/lib/aide/aide.db.new'
  $hour             = 3
  $minite           = 0
  $command          = "${::aide::params::aide_path} --check"
#  $check_parameters = "--config ${conf_path}"

  case $::osfamily {
    'Debian': {
      $aide_path = '/usr/bin/aide'
      $conf_path = '/etc/aide/aide.conf'
    }
    'Redhat': {
      $aide_path = '/usr/sbin/aide'
      $conf_path = '/etc/aide.conf'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
  $check_parameters = "--config ${conf_path}"
}
