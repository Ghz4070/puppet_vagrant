# Puppet (commandes) & TP

https://gist.github.com/glenux/e847d7a528b4e03ccdc9ce8591e00674

## Etat des lieux

### Sur le node 'control';

Lister le contenu du package puppet-master

    dpkg -L puppet-master

Voir l'état du service puppet-master

    sudo systemctl status puppet-master

### Sur les autres nodes

Lister le contenu du package puppet

    dpkg -L puppet

Démarrer le Puppet Agent

    sudo systemctl start puppet

Voir l'état du service puppet-agent

    sudo systemctl status puppet

## Se préparer à travailler avec puppet

Installer le puppet-lint (outil de vérification)

    sudo apt-get install puppet-lint

Utilisation

    puppet-lint demo/foo.pp

Exemple de contenu pour `foo.pp`

    file {
    'helloworld':
      path => '/tmp/helloworld',
      ensure => present,
      mode => 0640,
      content => "Helloworld via puppet ! "
    }

Corrigez-le à l'aide de _puppet-lint_ :wink:

## Commentaire #1

On définit des ressources

    ressource {
      'nom-de-l-objet-1':
        propriete =>; valeur,
        propriete =>; valeur,
        propriete =>; valeur,
        propriete =>; valeur,

      'nom-de-l-objet-2':
        propriete =>; valeur,
        propriete =>; valeur,
        propriete =>; valeur,
        propriete =>; valeur,
    }

Par la suite, je pourrai y faire référence, sous la
forme :

    Ressource['nom-de-l-objet-1']

Exemple de définition :

    file {
      'toto': ...
    }

Exemple de référence:

    file {
      'titi':
        ... ,
        require =>; File['toto'],
    }
