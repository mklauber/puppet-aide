# aide::watch defines a path/rule combination in the aide.conf file
define aide::watch ( $path,
  $exclude = false,
  $rules   = undef,
  $order   = 50
) {
  include aide

  $_rules = any2array($rules)

  $content = $exclude ? {
    true    => inline_template("!${path}"),
    default => inline_template("${path} <%= @_rules.join('+') %>\n")
  }

  concat::fragment { $path:
    target  => 'aide.conf',
    order   => $order,
    content => $content
  }
}