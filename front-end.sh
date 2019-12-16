#!/bin/bash
# actualizar repositorios
apt-get update

# instalamos apache2
apt-get install apache2 -y

# instalamos paquetes para apache
apt-get install php libapache2-mod-php php-mysql -y


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