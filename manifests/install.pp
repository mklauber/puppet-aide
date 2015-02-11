# class for managing aide installation
class aide::install inherits aide {
  package { 'aide':
    ensure => $::aide::version,
    name   => $::aide::package
  }

  # Create /var/lib/aide/lastrun file if it does not exist - Used with nagios check
  exec { "/usr/bin/touch /var/lib/aide/lastrun":
    unless  => "/usr/bin/test /var/lib/aide/lastrun",
    timeout => 0,
  }

  # Ensures initaidedb.sh script is present in /usr/sbin/
  file { '/usr/sbin/initaidedb.sh':
    ensure => 'present',
    source => 'puppet:///modules/aide/initaidedb.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
