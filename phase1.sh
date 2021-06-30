#!/bin/sh

# Paranoia mode
set -e
set -u

echo "phase1"

HOSTNAME="$(hostname)"
if [ "$HOSTNAME" != "control" ]; then
    sed -i \
        -e '/## BEGIN PROVISION/,/## END PROVISION/d' \
        /etc/puppet/puppet.conf
    cat >/etc/puppet/puppet.conf <<-MARK
## BEGIN PROVISION
[main] 
ssldir = /var/lib/puppet/ssl
certname = $HOSTNAME
server = control
environment = production 
[master]
vardir = /var/lib/puppet
cadir  = /var/lib/puppet/ssl/ca
dns_alt_names = puppet   
## END PROVISION
	MARK

    systemctl restart puppet

    # si puppet agent --test -> false alors || true on continue
    puppet agent --test || true
fi

echo "SUCCESS Phase 1."
