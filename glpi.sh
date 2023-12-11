apt update
apt upgrade -y

# INSTALLATION DES PRÉREQUIS
apt install -y apache2 mariadb-server php php-mysql php-curl php-gd php-intl php-ldap php-xml php-zip unzip php-mbstring php-bz2 sudo

# TÉLECHARGEMENT DE GLPI
wget -O /var/www/html/glpi.tgz https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz

cd /var/www/html/

tar -zxf glpi.tgz

# AUJOUT DES DROITS
chmod -R 755 /var/www/html
chmod -R 755 /var/www/html/glpi
chown -R www-data:www-data /var/www/html/glpi

# CREATION DATABASE MYSQL
mysql -e "CREATE DATABASE glpi;"
mysql -e "CREATE USER 'glpiuser'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON glpi.* TO 'glpiuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# TELECHARGEMENT FUSIONINVENTORY
cd /var/www/html/glpi/plugins/

wget https://github.com/fusioninventory/fusioninventory-for-glpi/archive/refs/tags/glpi10.0.6+1.1.tar.gz

tar xzvf glpi10.0.6+1.1.tar.gz

cp -r fusioninventory-for-glpi-glpi10.0.6-1.1/ fusioninventory

rm -rf fusioninventory-for-glpi-glpi10.0.6-1.1
rm glpi10.0.6+1.1.tar.gz

# RESTART SERVICE APACHE2
systemctl restart apache2

echo "GLPI et FUSIONINVENTORY est installé --> http://ip_address/glpi/"
