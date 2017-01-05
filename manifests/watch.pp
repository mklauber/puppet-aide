# aide::watch defines a path/rule combination in the aide.conf file
define aide::watch ( $path = $name,
  $type  = 'regular',
  $rules = undef,
  $order = 50
) {
  include aide

  $_rules = any2array($rules)
  $_type = downcase($type)

  validate_absolute_path($path)

  $content = $_type ? {
    'regular' => inline_template("${path} <%= @_rules.join('+') %>\n"),
    'equals'  => inline_template("=${path} <%= @_rules.join('+') %>\n"),
    'exclude' => inline_template("!${path}\n"),
    default   => fail("Type field value ${type} is invalid.  Acceptable values are ['regular', 'equals', 'excludes']")
  }

  concat::fragment { $title:
    target  => 'aide.conf',
    order   => $order,
    content => $content
  }
}
