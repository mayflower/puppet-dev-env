##
#   This is a node manifest for use in Vagrant
#
node 'puppet' {
  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games'
  }

  ##
  #   Setup the basic puppetmaster
  package { 'puppetmaster-passenger':
    ensure  => latest
  }

  file { '/var/lib/puppet':
    owner         => puppet,
    group         => puppet,
    recurse       => true,
    recurselimit  => 1,
    subscribe     => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => present,
    owner   => puppet,
    group   => puppet,
    content => '[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
templatedir=$confdir/templates

[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY
storeconfigs = true
storeconfigs_backend = puppetdb',
    require => [
      Package['puppetmaster-passenger'],
      Package['puppetdb-terminus'],
    ]
  }

  file { '/etc/puppet/routes.yaml':
    ensure  => present,
    content => "---
    master:
      facts:
        terminus: puppetdb
        cache: yaml",
    require => [
      Package['puppetmaster-passenger'],
      Package['puppetdb-terminus'],
    ]
  }

  package { 'puppetdb-terminus':
    ensure  => latest,
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/autosign.conf':
    ensure  => present,
    content => '*',
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/fileserver.conf':
    ensure  => present,
    content => '# Puppet
[files]
  path /etc/puppet/files
  allow *
#  allow *.example.com
#  deny *.evil.example.com
#  allow 192.168.0.0/24

[plugins]
#  allow *.example.com
#  deny *.evil.example.com
#  allow 192.168.0.0/24',
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/puppetdb.conf':
    ensure  => present,
    content => "[main]
server = puppet.dev
port = 8081
",
    require => [
      Package['puppetdb-terminus']
    ]
  }

  ##
  #   Passenger is part of apache2
  service { 'apache2':
    ensure  => running,
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/manifests':
    ensure  => link,
    force   => true,
    target  => '/puppet_manifests',
    notify  => Service['apache2'],
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/modules':
    ensure  => link,
    force   => true,
    target  => '/puppet_modules',
    notify  => Service['apache2'],
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/templates':
    ensure  => link,
    force   => true,
    target  => '/puppet_templates',
    notify  => Service['apache2'],
    require => Package['puppetmaster-passenger']
  }

  file { '/etc/puppet/files':
    ensure  => link,
    force   => true,
    target  => '/puppet_files',
    notify  => Service['apache2'],
    require => Package['puppetmaster-passenger']
  }

  ##
  #   Setup PuppetDB
  package { 'puppetdb':
    ensure  => latest,
    require => Package['puppetmaster-passenger']
  }

  service { 'puppetdb':
    ensure  => running,
    require => Package['puppetdb']
  }
}