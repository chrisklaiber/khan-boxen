class people::chrisklaiber {
  include brewcask

  package {
    [
      "autojump",
      "bash",
    ]:
  }

  package {
    [
      "caffeine",
      "colloquy",
      "dropbox",
      "firefox",
      "google-chrome",
      "hip-chat",
      "iterm2",
      "skype",
      "the-unarchiver",
    ]:
      ensure   => present,  # TODO(chris): implement "upgradeable" in puppet-brewcask
      provider => "brewcask",
      before   => Exec['brew cask linkapps'],
  }

  exec { 'brew cask linkapps':
    command => "${boxen_home}/homebrew/bin/brew cask linkapps --appdir=/Applications",
  }
}
