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
      provider => "brewcask"
  }
}
