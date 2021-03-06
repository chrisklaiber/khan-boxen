require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $luser,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::luser}"
  ]
}

File {
  group => 'staff',
  owner => $luser
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => Class['git']
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx
  include nvm

  # NOTE(chris): relax FDE requirement for initial rollout
  # fail if FDE is not enabled
  #if $::root_encrypted == 'no' {
  #  fail('Please enable full disk encryption and try again')
  #}

  # node versions
  include nodejs::0-8

  # default ruby versions
  include ruby::1_8_7

  # common, useful packages
  package {
    [
      'ack',
      'coreutils',
      'findutils',
      'gnu-tar',
      'mercurial',
    ]:
  }

  # unfortunately, we require homebrew head-only packages
  exec { "brew tap homebrew/headonly":
    user => $luser,
    creates => "${homebrew::config::tapsdir}/homebrew-headonly",
  }
  package {
    ['git-hg']:
      require => Exec['brew tap homebrew/headonly'],
      install_options => [ '--HEAD' ],
  }

  include projects::all

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
