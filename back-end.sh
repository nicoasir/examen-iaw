#!/bin/bash
#Actualizamos repositorios
apt-get update

# configurar la contraseña de root para mysql(!!!!ANTES DE INSTALAR MYSQL!!)
DB_ROOT_PASSWD=root
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DB_ROOT_PASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DB_ROOT_PASSWD"

# instalamos mysql server
apt-get install mysql-server -y

# configuramos la aplicacion web
DB_NAME=bdjoomla
DB_USER=lamp_user
DB=PASSWD=lamp_user
mysql -u root -p$DB_ROOT_PASSWD <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWD <<< "CREATE DATABASE $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWD <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASSWD';"
mysql -u root -p$DB_ROOT_PASSWD <<< "FLUSH PRIVILEGES;"

# privilegios usuario
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON bdjoomla.* TO 'lamp_user'@'%' IDENTIFIED BY 'lamp_user';
FLUSH PRIVILEGES;

# configurar mysql para conexion externa /etc/mysql/mysql.conf.d/mysqld.cnf
cd /etc/mysql/mysql.conf.d/
sed -i "s/127.0.0.1/0.0.0.0/" mysqld.cnf
#en mysqld bin-address cambiar 127.0.0.1 por 0.0.0.0

/etc/init.d/mysql restart