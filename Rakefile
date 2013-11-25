require 'rubygems'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send("disable_80chars")

task :default => [:spec, :lint]
