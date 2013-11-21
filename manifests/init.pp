class janus {
  $home = "/Users/${::boxen_user}"
  $vimdir = "${home}/.vim"
  $vimrc = "${home}/.vimrc"
  $gvimrc = "${home}/.gvimrc"

  package { 'vim':
    require => Package['mercurial']
  }

  package { 'mercurial':
    require => Package['docutils']
  }

  package { 'docutils':
    ensure   => installed,
    provider => pip,
  }

  # Modified from https://gist.github.com/jfryman/4963514
  repository { 'janus':
    source => 'carlhuda/janus',
    path   => $vimdir,
    require => [
      Package['vim'],
      Package['ctags']
    ]
  }
  ~> exec { 'Boostrap Janus':
    command     => 'rake',
    cwd         => $vimdir,
    environment => [
      "HOME=${home}",
    ],
  }
}
