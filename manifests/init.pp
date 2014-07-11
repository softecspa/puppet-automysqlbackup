# == Class automysqlbackup
#
# this module manage installatio and configuration of automysqlbackup
#
# === Parameters
# [*databases*]
#   list of databases to backup in the form of a string: 'db1 db2 db3'. Default: all
#
# [*backupdir*]
#   Destination path for backup. Default: /var/backup/mysql
#
# [*minute*]
#   Cron schedulation minute: default: 30
#
# [*hour*]
#   Cron schedulation hour. Default: 00
#
# [*send_ncsa*]
#   If true, cron entry call a wrapper that execute automysqlbackup and after send a ncsa to nagios. Default: false
#
# [*mailaddr*]
#   Mail address to send backup report
#
# [*nagios*]
#   Nagios fqdn to send ncsa. Default: global variable $::nagios_fqdn
#
# [*mysql_server*]
#   Name of monitored host in nagios. Default: $::hostname
#
class automysqlbackup (
  $databases          = 'all',
  $backupdir          = '/var/backups/mysql',
  $minute             = '30',
  $hour               = '00',
  $send_ncsa          = false,
  $mailaddr           = $::backup_mail,
  $nagios             = $::nagios_fqdn,
  $mysql_server       = $::hostname,
){

  include automysqlbackup::install
  include automysqlbackup::config

  Class['automysqlbackup::install'] ->
  Class['automysqlbackup::config']

}
