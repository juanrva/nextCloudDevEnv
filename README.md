# nextCloudDevEnv

Requirements:
- vagrant

Install steps:

- `git clone https://github.com/juanrva/nextCloudDevEnv` //get this repo
- `cd nextCloudDevEnv` 
- `vagrant up` //fire up the virtual machine
- `vagrant ssh` //ssh into it
- `git clone https://github.com/nextcloud/server.git /var/www/nextcloud/server/` //get nextcloud server code
- `cd /var/www/nextcloud/server/`
- `git submodule update --init` //get submodules
- go into your browser to http://192.168.33.20/nextcloud/)[http://192.168.33.20/nextcloud/
- add your own user and pass
- set `/home/vagrant/nextcloud_data` as Data Folder
- set Database User: `nextclouder`
- set Database Password: `nextclouder_pass123pass`
- set Database Name: `nextcloud`
