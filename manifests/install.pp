# class for managing aide installation
class aide::install inherits aide {
  package { 'aide':
    ensure => $::aide::version,
    name   => $::aide::package
  }

  # Create /tmp/aide file if it does not exist - Used with nagios check
  exec { "/usr/bin/touch /tmp/aide":
    unless => "/usr/bin/test -d /tmp/aide"
    }
}
