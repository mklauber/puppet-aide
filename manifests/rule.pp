# aide::rule defines a rule that should be included in the aide.conf file.
define aide::rule ($rules) {
  include aide
  
  $_rules = any2array($rules)

  concat::fragment { $name:
    target  => 'aide.conf',
    order   => 03,
    content => inline_template("${name} = <%= @_rules.join('+') %>\n")
  }
}