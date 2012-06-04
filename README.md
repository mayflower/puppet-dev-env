# puppet-dev-env

A vagrant environment to ease the pain of developing manifests & modules.

## Setup

In order to use this you need the following directories (and appropriate sources ;):

* manifests
* modules
* templates
* files

Wether you `git clone`, `ln -s` or `cp` them doesn't matter.

### Vagrant plugins
Install the vagrant-dns plugin.

`gem install vagrant-dns`

**NOTE:** _OS X-only_ at the moment. :(

### Ruby …

… meh. I recommend to use rvm with Ruby 1.9.2. The repository has an rvmrc.

`rvm use 1.9.2`
`rvm gemset create vagrant`
`rvm use 1.9.2@vagrant`


#### TODO

* Fix DNS on non-OS X platforms.

### Using puppet-admin

Clone puppet-admin into your clone of puppet-env-ng.

`$ git clone git@git.mayflower.de:puppet-admin.git`

Link the directories from puppet-admin.

`$ ln -s puppet-admin/manifests`

`$ ln -s puppet-admin/modules`

`$ ln -s puppet-admin/templates`

`$ ln -s puppet-admin/files`

**NOTE**: You may need to `gitsubmodule update --init` in puppet-admin.


## Running the machines

### Mocking nodes

You can export `VAGRANT_NODES` with a comma separated list of node names.

`$ export VAGRANT_NODES=foo,bar`

`$ vagrant up master`

`$ vagrant up foo`

You can also do `vagrant status` to check that things are okay.

**FIXME:** Currently the ordering of `VAGRANT_NODES` is **essential to assign IP addresses**, don't change it if you have running VMs!

### Start the master

Do this before you start any other VMs. ;)

```
$ vagrant up master
```
