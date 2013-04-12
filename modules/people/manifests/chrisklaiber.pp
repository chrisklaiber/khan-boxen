class people::chrisklaiber {
  include brewcask

  package {
    [
      "caffeine",
      "colloquy",
      "dropbox",
      "firefox",
      "google-chrome",
      "iterm2",
      "skype",
      "the-unarchiver",
    ]:
      provider => "brewcask"
  }
}
