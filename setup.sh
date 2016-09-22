#! /bin/bash

echo "++++++++++ setting up locale language... +++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
locale-gen en_GB.UTF-8



echo "++++++++++ Update repos... +++++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
# apt-get update

echo "++++++++++ Installing git... +++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
apt-get install git -y

echo "++++++++++ Installing apache and php...+++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
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


echo "++++++++++++++++++ Clone nextcloud...+++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
git clone https://github.com/nextcloud/server.git /var/www/nextcloud/server/
