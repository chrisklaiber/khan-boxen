
# This class ensures source code and supporting software for development
# at Khan Academy, for things like code reviews. It assumes that "boxen"
# is run from the developer's user account.

class projects::devtools {
  $devtools = "/Users/${luser}/devtools"

  file { $devtools: ensure => 'directory' }

  repository { "$devtools/khan-dotfiles": source => 'Khan/khan-dotfiles' }
  repository { "$devtools/kiln-review": source => 'Khan/kiln-review' }
  repository { "$devtools/khan-linter": source => 'Khan/khan-linter' }
  repository { "$devtools/arcanist": source    => 'Khan/arcanist' }
  repository { "$devtools/libphutil": source   => 'Khan/libphutil' }
  vcsrepo { "${devtools}/mercurial-extensions-rdiff":
    source   => 'https://bitbucket.org/brendan/mercurial-extensions-rdiff',
    provider => 'hg',
    require  => Package['mercurial'],
  }
  exec { "/usr/bin/curl https://khanacademy.kilnhg.com/Tools/Downloads/Extensions > /tmp/extensions.zip && /usr/bin/unzip /tmp/extensions.zip -d ${devtools}":
    user    => $luser,
    creates => "${devtools}/kiln_extensions",
  }
}
