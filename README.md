mklauber-aide
===========

Build Status: [![Build Status](https://travis-ci.org/mklauber/puppet-aide.png)](https://travis-ci.org/mklauber/puppet-aide)

`mklauber/aide` is a puppet module for managing Aide (Advanced Intrustion Detection Environment). It allows you to define Rules and File/folder watches via defined types.  Refer to the Aide [manual](http://aide.sourceforge.net/stable/manual.html) for details about Aide configuration options.


Examples
==========

Watch permissions of all files on filesystem
----------

The simplest use of `mklauber/aide` is to place a watch on the root directory, as follows.

    aide::watch { 'example':
      path  => '/',
      rules => 'p'
    }
    
This example adds the line `/ R` which watches the permissions of all files on the operating system.  Obviously, this is a simplistic, non useful solution.

Watch permissions and md5sums of all files in /etc
----------

    aide::watch { 'example':
      path  => '/etc',
      rules => 'p+md5'
    }
    
This example adds the line `/etc p+md5` which watches `/etc` with both permissions and md5sums.  This could also be implemented as follows.

    aide::watch { 'example':
      path  => '/etc',
      rules => ['p', 'md5']
    }
    

Create a common rule for watching multiple directories
-----------

Sometimes you wish to use the same rule to watch multiple directories, and in keeping with the Don't Repeat Yourself(DRY) viewpoint, we should create a common name for the rule.  This can be done via the `aide::rule` stanza.

    aide::rule { 'MyRule':
      name  => 'MyRule',
      rules => ['p', 'md5']
    }
    aide::watch { '/etc':
      path  => '/etc',
      rules => 'MyRule'
    }
    aide::watch { 'otherApp':
      path  => '/path/to/other/config/dir',
      rules => 'MyRule'
    }

Here we are defining a rule in called **MyRule** which will add the line `MyRule = p+md5`.  The next two stanzas can reference that rule.  They will show up as `/etc MyRule` and `/path/to/other/config/dir MyRule`.

Create a rule to exlude directories
-----------

    aide::watch { '/var/log':
      path => '/etc',
      type => 'exclude' 
    }

This with ignore all files under /var/log.  It adds the line `!/var/log` to the config file.

Create a rule to specify only specific files
-----------

    aide::watch { '/var/log/messages':
      path => '/etc',
      type => 'equals',
      rules => 'MyRule'
    }

This with watch only the file /var/log/messages.  It will ignore /var/log/messages/thingie.  It adds the line `=/var/log/messages MyRule` to the config file.






