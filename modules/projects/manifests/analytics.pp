
# This class ensures source code and supporting software for developing
# within the Khan Academy analytics codebase. It assumes that "boxen" is
# run from the developer's user account.

class projects::analytics {
  $khan = "/Users/${luser}/khan"

  package {
    [
      's3cmd',
      'gnupg',  # used by s3cmd
    ]:
  }

  repository { "${khan}/analytics": source => 'Khan/analytics' }
}
