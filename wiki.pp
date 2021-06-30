class dokuwiki {
    package {
        'apache2':
            ensure => present
    }
    package {
        'php7.3':
            ensure => present
    }
    file {
        'download tgz dokuwiki':
            ensure => present,
            path   => '/usr/src/dokuwiki.tgz',
            source => 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz'
    }
    exec {
        'extract dokuwiki':
            command => 'tar xavf dokuwiki.tgz',
            cwd     => '/usr/src',
            path    => ['/usr/bin'],
            require => File['download tgz dokuwiki']
    }
    file {
        'rename dokuwiki':
            ensure  => present,
            path    => '/usr/src/dokuwiki',
            source  => '/usr/src/dokuwiki-2020-07-29',
            require => Exec['extract dokuwiki']
    }
    file {
        'delete extracted dokuwiki':
            ensure  => absent,
            path    => '/usr/src/dokuwiki-2020-07-29',
            require => File['rename dokuwiki']
    }
}

define deploy_wiki($site) {
    file {
        "create ${site} directory":
            ensure  => directory,
            path    => "/var/www/${site}",
            source  => '/usr/src/dokuwiki',
            recurse => true,
            owner   => 'www-data',
            group   => 'www-data',
            require => File['rename dokuwiki']
    }
}

node 'server0' {
    include dokuwiki
    deploy_wiki { 
        "recettes":
            site => "recettes.wiki";
        "couscous.com":
            site => "couscous.com";
  }
}

node 'server1' {
    include dokuwiki
    deploy_wiki { 
        "politique":
            site => "politique.wiki",
  }
}
