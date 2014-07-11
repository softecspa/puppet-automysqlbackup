class automysqlbackup::install {

  if $::lsbdistcodename == 'hardy' {
    apt::ppa { 'jeff-bitprophet/ppa':
      key     => '3FCA1EF2',
      mirror  => true
    }

    Apt::Ppa['jeff-bitprophet/ppa'] ->
    Package['automysqlbackup']
  }

  package {'automysqlbackup':
    ensure  => present,
  }
}
