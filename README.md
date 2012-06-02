# puppet-env-ng

A vagrant environment to ease the pain of developing manifests & modules.

## Setup

In order to use this you need to:

  * Put your manifests in ./manifests
  * Put your modules in ./modules

Wether you `git clone`, `ln -s` or `cp` them doesn't matter.

### Vagrant plugins
Install the vagrant-dns plugin.

`gem install vagrant-dns`

### Ruby …

… meh. I recommend to use rvm with Ruby 1.9.2. The repository has an rvmrc.

`rvm use 1.9.2`
`rvm gemset create vagrant`
`rvm use 1.9.2@vagrant`


#### TODO

* Fix DNS

### Using puppet-admin

Clone puppet-admin into your clone of puppet-env-ng.

`$ git clone git@git.mayflower.de:puppet-admin.git`

Link the manifests from puppet-admin.

`$ ln -s puppet-admin/manifests`

Link the modules from puppet-admin.

`$ ln -s puppet-admin/modules`

**NOTE**: You may need to `gitsubmodule update --init` in puppet-admin.


## Running the machines

### Mocking nodes

You can export `VAGRANT_NODES` with a comma separated list of node names.

`$ export VAGRANT_NODES=foo,bar`

`$ vagrant up master`

`$ vagrant up foo`

You can also do `vagrant status` to check that things are okay.

### Start the master
```
$ vagrant up master
```

### Start a node

## Hack