#!/bin/bash
# actualizar repositorios
apt-get update

# instalamos apache2
apt-get install apache2 -y

# instalamos paquetes para apache
apt-get install php libapache2-mod-php php-mysql -y
add-apt-repository ppa:ondrej/php
apt-get install php7.2-fpm php7.2-dev php7.2-curl php7.2-xmlrpc php7.2-gd php7.2-mysql php7.2-mbstring php7.2-xml  libapache2-mod-php php7.2-soap php7.2-cli


# bajar joomla
cd /var/www/html
mkdir joomla
cd /var/www/html/joomla
wget http://joomlacode.org/gf/download/frsrelease/12649/53618/Joomla_1.5.20-Spanish-pack_completo.tar.gz
tar zxvf Joomla_1.5.20-Spanish-pack_completo.tar.gz
chown www-data:www-data * -R

#cambiar archivo de configuracion poniendo base de datos, usuario...
cd /var/www/html/joomla
sed -i "s/database/wordpress/" configuration.php
sed -i "s/db_user/lamp_user/" configuration.php
sed -i "s/password/lamp_user/" configuration.php
sed -i "s/localhost/3.90.51.220/" configuration.php
