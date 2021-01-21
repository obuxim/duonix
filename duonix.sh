#!/bin/bash
echo 'Allowing PORTS' &&
sudo ufw allow 80 &&
sudo ufw allow 443 &&
echo 'Installing HTTPS Transport' &&
sudo apt-get install apt-transport-https -y &&
echo 'Adding ondrej/php repository' &&
sudo add-apt-repository ppa:ondrej/php &&
echo 'Refreshing APT Repositories' &&
sudo apt-get update -y &&
echo 'Uninstalling PHP'
sudo apt-get purge -y php* &&
read -p 'Enter the PHP Version you want to install: (e.g. 7.3)' phpversion
echo 'Installing PHP' &&
sudo apt-get install -y php$phpversion php$phpversion-common php$phpversion-fpm php$phpversion-mysql php$phpversion-pgsql php$phpversion-mbstring php$phpversion-xml php$phpversion-zip php$phpversion-gd libapache2-mod-php$phpversion &&
echo 'Uninstalling Apache' &&
sudo apt-get remove apache2 &&
sudo apt-get purge apache2 &&
echo 'Installing Nginx' &&
sudo apt-get install nginx &&
echo 'Starting Nginx' &&
sudo systemctl start nginx
echo 'Swapping Default Nginx Configuration' &&
sudo rm /etc/nginx/sites-available/default &&
sudo cp ./default /etc/nginx/sites-available/default &&
echo 'Installing MariaDB' &&
sudo apt-get install -y mariadb-server mariadb-client &&
echo 'Starting MariaDB Server' &&
sudo systemctl start mariadb &&
echo 'Adding Nginx & MariaDB to startup' &&
sudo systemctl enable nginx &&
sudo systemctl enable mariadb &&
echo 'Configuring MySQL' &&
sudo mysql_secure_installation &&
echo 'Installing phpMyAdmin' &&
sudo apt-get install -y phpmyadmin &&
sudo ln -s /usr/share/phpmyadmin /var/www/html &&
echo 'Please configure a new User for phpMyAdmin and Login.' &&
echo '-----------------------------------------------------------' &&
echo 'Server is ready!' &&
echo '-----------------------------------------------------------' &&
echo 'Zubair Hasan [Duoneos] - z@duoneos.com'
