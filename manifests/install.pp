# class for managing aide installation
class aide::install inherits aide {
  package { 'aide':
    ensure => $::aide::version,
    name   => $::aide::package
  }

  # Create /var/lib/aide/lastrun file if it does not exist - Used with nagios check
  exec { "/usr/bin/touch /var/lib/aide/lastrun":
    unless => "/usr/bin/test /var/lib/aide/lastrun"
  }

  file { '/etc/default/aide':
    ensure => present,
  }->
  file_line { 'Append a line to /etc/default/aide':
    path   => '/etc/default/aide',  
    line   => 'COPYNEWDB=no',
    match  => 'COPYNEWDB=yes',
  }
}
