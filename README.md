puppet-automysqlbackup
======================

install, configure, fix and manage automysqlbackup

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
 * [Setup requirements](#setup-requirements)
4. [Default config options](#default-config-options)

##Overview
This module install automysqlbackup. It also make some customization.

##Module Description
This module:

 * install automysqlbackup
 * delete the default cron entry
 * on the executable add the evalution of OPT variable from /etc/default/automysqlbackup
 * if you send\_ncsa is enabled it uses a wrapper to lauch backup

##Setup

    include automysqlbackup

if you want to send a ncsa:

    class {'automysqlbackup':
      send_ncsa => true
    }

###Setup Requirements

 * **only on hardy**: softecspa/puppet-apt module
 * softecspa/puppet-cron module

## Default config options

Module uses some global variable as default config:

 * $::backup\_mail: mail to send email with backup result
 * $::nagios\_fqdn: fqdn of nagios server. It's used to send ncsa
