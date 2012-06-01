# puppet-env-ng

A vagrant environment to ease the pain of developing manifests & modules.

## Setup

In order to use this you need to:

  * Put your manifests in ./manifests
  * Put your modules in ./modules

Wether you `git clone`, `ln -s` or `cp` them doesn't matter.

### Using puppet-admin

Clone puppet-admin into your clone of puppet-env-ng.

`$ git clone git@git.mayflower.de:puppet-admin.git`

Link the manifests from puppet-admin.

`$ ln -s puppet-admin/manifests`

Link the modules from puppet-admin.

`$ ln -s puppet-admin/modules`

**NOTE**: You may need to `gitsubmodule update --init` in puppet-admin.

## Running the machines

### Start the master
```
$ vagrant up master
```

### Start a node
TODO

## Hack

## TODO

* Figure out how to create _dynamic_ node(name)s in Vagrant.