
# This class ensures source code and supporting software for developing
# the Khan Academy website. It assumes that "boxen" is run from the
# developer's user account.

class projects::website {
  $home = "/Users/${luser}"
  $khan = "${home}/khan"

  package {
    [
      'google-app-engine'
    ]:
  }

  $website_stable = 'https://khanacademy.kilnhg.com/Code/Website/Group/stable'
  exec { "hg clone ${website_stable} ${khan}/website/stable":
    user    => $luser,
    creates => "${khan}/website/stable",
    require => Package['mercurial'],
  }

  file { "${khan}/datastore":
    ensure => 'directory',
  }

  file { "${khan}/datastore/blobs":
    ensure => 'directory',
    require => File["${khan}/datastore"],
  }

  # Try to copy in a datatore but don't bail on failure, i.e., if the
  # Dropbox path is wrong or not set up.
  $current_sqlite_path = "${home}/Dropbox/Khan Academy All Staff/Other shared items/datastores/current.sqlite"
  exec { "/bin/cp \"${current_sqlite_path}\" ${khan}/datastore/current.sqlite":
    creates => "${khan}/datastore/current.sqlite",
    onlyif  => "/bin/test -f \"${current_sqlite_path}\"",
    require => File["${khan}/datastore"],
  }
}
