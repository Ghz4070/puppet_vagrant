## TP2 - Un systeme haute-disponibilité

L'objectif de ce TP est d'installer, à l'aide de puppet, un hébergement haute
disponibilité pour NextCloud (un logiciel libre permettant de fournir des
services SaaS privés équivalents à Google Cloud)

Il s'agira d'installer 6 serveurs:

- CONTROL: une machine pour le puppet master
- REVPROXY: un serveur caddy
- APP1 et APP2: deux serveur applicatif NextCloud
- DB: un serveur de base de données MariaDB
- CACHE: un serveur de cache Redis

Toutes les serveurs, à l'exception de CONTROL, seront installées et controlées
par Puppet.

## A. Préparation des serveurs

A cette étape, on veut préparer les serveurs. On utilisera

- soit 6 VPS sur l'hébergeur de votre choix (OVH, Digital Ocean, Linode, etc.)
- soit 6 machines virtuelles en local
- soit 6 LXC en local

1. Créer les serveurs (chez l'hébergeur) ou écrire un Vagrantfile

## B. Liens entre puppet master et puppet agent

Ecrire un premier script shell (`phase1.sh`) pour installer et configurez puppet sur les serveurs

- si le hostname est CONTROL,
  - installer le puppet-master (`apt-get update && apt-get intall ...`)
  - vérifier qu'il est bien lancé (`ps aux | grep ...`)
- si c'est les autres nodes
  - installer le puppet-agent (`apt-get update && apt-get intall ...`)
  - relancer le puppet agent (`systemctl restart ...`)
  - vérifier qu'il est bien lancé (`ps aux | grep ...`)
  - écrire la configuration
    - pour se connecter sur le Puppet Master (voir `/etc/puppet/puppet.conf`)
    - pour déclarer leur nom au Puppet Master (`puppet agent --test`)

Ecrire un second script (`phase2.sh`) pour :

Permet de lancer le phase2.sh manuellement depuis control
`vagrant ssh control -c "sudo /vagrant/phase2.sh" `

3. Autorisez l'accès des autres serveurs sur CONTROL (`puppet cert sign X`)

Utilisez ces deux scripts depuis Vagrant ou sur vos serveurs

## C. Echaffaudage

- Créer un fichier `site.pp`
  - avec des classes (vides) pour les différents éléments à installer
  - liste les différents nodes et les classes qui devront être inclues dans chaque node

## D. Installation de la base de données

## E. Installation de l'application
