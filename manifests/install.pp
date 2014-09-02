# class for managing aide installation
class aide::install inherits aide {
  package { 'aide':
    ensure => $::aide::version,
    name   => $::aide::package
  }

  # Create /tmp/aide file if it does not exist - Used with nagios check
  exec { "/usr/bin/touch /var/lib/aide/lastrun":
    unless => "/usr/bin/test /var/lib/aide/lastrun"
    }
}
