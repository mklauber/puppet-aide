# aide::params sets the default values for parameters.
class aide::params {
  $package      = 'aide'
  $version      = latest
  $db_path      = '/var/lib/aide/aide.db.gz'
  $db_temp_path = '/var/lib/aide/aide.db.new'
  $hour         = 0

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
  $aide_rules_defaults = {
    $name = undef,
    $rules = undef,
  }
}
