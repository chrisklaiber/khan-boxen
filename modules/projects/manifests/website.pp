class projects::website {
  package {
    [
      'google-app-engine'
    ]:
  }

  # TODO(chris): remove /tmp/ and put in $USER/khan/website/stable
  # TODO(chris): this returns a 255 error code for auth but works when
  # run locally with "env -i -- COMMAND".  Not sure what is going on.
  #vcsrepo { '/tmp/website-stable':
  #  ensure   => present,
  #  provider => hg,
  #  source   => 'https://khanacademy.kilnhg.com/Code/Website/Group/stable',
  #}
}
