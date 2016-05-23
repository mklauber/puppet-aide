# the aide class manages some the configuration of aide
class aide (
    $package      = $aide::params::package,
    $version      = $aide::params::version,
    $conf_path    = $aide::params::conf_path,
    $db_path      = $aide::params::db_path,
    $db_temp_path = $aide::params::db_temp_path,
    $minute       = $aide::params::minute
  ) inherits aide::params {

  anchor { 'aide::begin': } ->
  class  { '::aide::install': } ->
  class  { '::aide::config': } ~>
  class  { '::aide::firstrun': } ->
  class  { '::aide::cron': } ->
  anchor { 'aide::end': }
}
