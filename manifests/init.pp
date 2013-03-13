# Public: Install bash into Homebrew, add to /etc/shells and change the user's
# shell to it.
#
# Examples
#
#   include bash
class bash {
  require boxen::config

  package {
    'bash': ;
    'bash-completion': ;
  }

  file_line { 'add bash to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/bash",
    require => Package['bash'],
  }

  osx_chsh { $::luser:
    shell   => "${boxen::config::homebrewdir}/bin/bash",
    require => File_line['add bash to /etc/shells'],
  }
}
