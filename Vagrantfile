# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.define :ftp do |ftp|

    # rsync only the salt roots
    ftp.vm.synced_folder ".", "/vagrant", disabled: true
    ftp.vm.synced_folder "salt/roots/", "/srv/salt/", type: "rsync", rsync__exclude: ".DS_Store"

    # digital ocean override
    ftp.vm.provider :digital_ocean do |ocean, override|
      override.vm.box = "digital_ocean"
      override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
      override.ssh.private_key_path = "~/.ssh/vagrant"
      override.vm.hostname = "fewd.ninja"

      ocean.token = ENV["DIGITAL_OCEAN_TOKEN"]
      ocean.size = "512mb"
      ocean.region = "nyc3"
      ocean.image = "ubuntu-14-04-x64"
      ocean.ssh_key_name = "Vagrant"
    end

    # provision with salt
    ftp.vm.provision :salt do |salt|
      salt.minion_config= "salt/minion"
      salt.run_highstate = true
      salt.verbose = true
    end

  end

end
