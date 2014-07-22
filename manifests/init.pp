# the aide class manages some the configuration of aide
class aide (
    $package      = $aide::params::package,
    $version      = $aide::params::version,
    $conf_path    = $aide::params::conf_path,
    $db_path      = $aide::params::db_path,
    $db_temp_path = $aide::params::db_temp_path,
    $hour         = $aide::params::hour
  ) inherits aide::params {

  anchor { 'aide::begin': } ->
  class  { '::aide::install': } ->
  class  { '::aide::config': } ~>
  class  { '::aide::firstrun': } ->
  class  { '::aide::cron': } ->
  anchor { 'aide::end': }

  $aide::rules_hash = hiera_hash( 'aide_rules', $aide::params::aide_rules_defaults )
  create_resources('aide::rule', $aide::rules_hash)
}
