class aide::install inherits aide {
  package { 'aide':
    ensure => $::aide::version,
    name   => $::aide::package
  }
}