# the aide class manages some the configuration of aide
class aide (
    $package          = $aide::params::package,
    $version          = $aide::params::version,
    $conf_path        = $aide::params::conf_path,
    $db_path          = $aide::params::db_path,
    $db_temp_path     = $aide::params::db_temp_path,
    $hour             = $aide::params::hour,
    $minute           = $aide::params::minute,
    $command          = $aide::params::command,
    $check_parameters = $aide::params::check_parameters,
  ) inherits aide::params {

  anchor { 'aide::begin': } ->
  class  { '::aide::install': } ->
  class  { '::aide::config': } ~>
  class  { '::aide::firstrun': } ->
  class  { '::aide::cron': } ->
  anchor { 'aide::end': }

  # Creates resources for aide::rule pulled from hiera
  $aide_rules = hiera_hash( 'aide::rules_hash', false )
  if $aide_rules {
    create_resources('aide::rule', $aide_rules)
  }

  # Creates resources for aide::watch pulled from hiera
  $aide_watch = hiera_hash( 'aide::watch_hash', false )
  if $aide_watch {
    create_resources('aide::watch', $aide_watch)
  }
}
