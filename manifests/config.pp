class automysqlbackup::config {

  include automysqlbackup
  include automysqlbackup::params

  if !defined(File[$automysqlbackup::backupdir]) {
    file { $automysqlbackup::backupdir :
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0644'
    }
  }

  file {$automysqlbackup::params::defaultfile :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('automysqlbackup/etc/automysqlbackup.erb')
  }

  file {$automysqlbackup::params::defaultcron:
    ensure  => absent,
  }

  # la variabile OPT viene dichiarata dopo l'inclusione del file /etc/default/automysqlback, questo impedisce di manipolare la variabile se non nel
  # nell'eseguibile.
  exec {'fix OPT automysqlbackup':
    command => '/bin/sed -e \'s/OPT="--quote-names"/OPT="$OPT --quote-names"/\' -i /usr/sbin/automysqlbackup',
    onlyif  => '/bin/grep \'OPT="--quote-names"\' /usr/sbin/automysqlbackup'
  }

  if $automysqlbackup::send_ncsa {
    file {'/usr/sbin/automysqlbackup_ncsa':
      ensure  => present,
      mode    => '0754',
      owner   => 'root',
      group   => 'root',
      content => template('automysqlbackup/sbin/automysqlbackup_ncsa.erb')
    }
    $cron_executable = '/usr/sbin/automysqlbackup_ncsa'
  }
  else {
    $cron_executable = $automysqlbackup::params::executable
  }

  cron::customentry { 'automysqlbackup':
    ensure  => 'present',
    command => "test -x $cron_executable && $cron_executable",
    minute  => $automysqlbackup::minute,
    hour    => $automysqlbackup::hour,
  }
}
