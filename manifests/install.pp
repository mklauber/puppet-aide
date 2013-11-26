# class for managing aide installation
class aide::install inherits aide {
  package { 'aide':
    ensure => $::aide::version,
    name   => $::aide::package
  }
}