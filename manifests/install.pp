class automysqlbackup::install {

  if $::lsbdistcodename == 'hardy' {
    softec_apt::ppa {'jeff-bitprophet/ppa':
      mirror  => true,
      key     => '3FCA1EF2'
    }

    Softec_apt::Ppa['jeff-bitprophet/ppa'] ->
    Package['automysqlbackup']
  }

  package {'automysqlbackup':
    ensure  => present,
  }
}
