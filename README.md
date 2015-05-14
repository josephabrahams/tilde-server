# tilde.club Style Server Provisioner

Use Vagrant to provision a Digital Ocean cloud server similar to 
[tilde.club](https://github.com/tildeclub/tilde.club) running Ubuntu 14.04 via SaltStack.

Packages included:

- apache w/ userdirs enabled
- build-essential
- curl
- vsftp

## Install Vagrant

    $ brew cask install vagrant
    $ vagrant plugin install vagrant-digitalocean

## Export Digital Ocean Access Token

    $ export DIGITAL_OCEAN_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

## Add pillar data

salt/roots/pillar/top.sls

    base:
      '*':
        - groups
        - users

salt/roots/pillar/groups.sls

    groups:
      examplegroup:
        gid: 2000

salt/roots/pillar/users.sls

    users:
      jdoe:
        fullname: John Doe
        uid: 2001
        gid: 2001
        home: /home/jdoe
        shell: /bin/bash
        keys:
          - ssh-rsa AAA...3bp john@doe.net
        groups:
          - examplegroup
        optional_groups:
          - adm
          - sudo

## Provision the server

    $ vagrant up
