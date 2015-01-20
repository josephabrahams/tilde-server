# fewd.ninja Server Provisioner

Use Vagrant to provision a Digital Ocean cloud server running Ubuntu 14.04 and using SaltStack.

## Install Vagrant

    $ brew cask install vagrant
    $ vagrant plugin install vagrant-digitalocean

## Export Digital Ocean Access Token

    $ export DIGITAL_OCEAN_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

## Add pillar data

top.sls

    base:
      '*':
        - groups
        - users

groups.sls

    groups:
      examplegroup:
        gid: 2000

users.sls

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
