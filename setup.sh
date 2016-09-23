#! /bin/bash

echo "++++++++++ setting up locale language... +++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
locale-gen en_GB.UTF-8



echo "++++++++++ Update repos... +++++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
apt-get update

echo "++++++++++ Installing git... +++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
apt-get install git -y

echo "++++++++++ Installing apache and php...+++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php5-5.6
apt-get update
apt-get upgrade -y
apt-get install php5 -y
apt-get install apache2 libapache2-mod-php5 -y
apt-get install php5-gd php5-json php5-mysql php5-curl -y
apt-get install php5-intl php5-mcrypt php5-imagick -y


echo "**********Install maria DB***********"
echo "*************************************"
# This will turn off "frontend" (prompts) during installations
export DEBIAN_FRONTEND=noninteractive

debconf-set-selections <<< 'mariadb-server-5.5 mysql-server/root_password password pass123pass'
debconf-set-selections <<< 'mariadb-server-5.5 mysql-server/root_password_again password pass123pass'
apt install mariadb-server-5.5 -y

echo "++++++++++++++++++ Run setup.sql...+++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
mysql -uroot -ppass123pass < /var/www/nextcloud/setup.sql


if [ ! -d "/var/www/nextcloud/server/" ]; then
    echo "++++++++++++++++++ Clone nextcloud...+++++++++++++++"
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    git clone https://github.com/nextcloud/server.git /var/www/nextcloud/server/
    git submodule update --init
else
    echo "++++++++++++++++++ Nextcloud already cloned.+++++++++++++++"
fi

if [ ! -f "/etc/apache2/sites-available/nextcloud.conf" ]; then
    echo 'Alias /nextcloud "/var/www/nextcloud/server/"

        <Directory /var/www/nextcloud/server/>
          Options +FollowSymlinks
          AllowOverride All

         <IfModule mod_dav.c>
          Dav off
         </IfModule>

         SetEnv HOME /var/www/nextcloud/server
         SetEnv HTTP_HOME /var/www/nextcloud/server

        </Directory>' > /etc/apache2/sites-available/nextcloud.conf

    ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/nextcloud.conf
else
    echo "++++++++++++++++++ nextcloud.conf already created.+++++++++++++++"
fi

a2enmod rewrite
a2enmod headers
a2enmod env
a2enmod dir
a2enmod


printf "Creating possible missing Directories\n"
mkdir -p /home/vagrant/nextcloud_data
chown -R www-data:www-data nextcloud_data/
mkdir -p $ocpath/assets
mkdir -p $ocpath/updater


echo "++++++++++++++++++ Restart apache.+++++++++++++++"
service apache2 restart
