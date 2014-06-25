#!/bin/sh

echo "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo "Updating Homebrew"
brew update
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/science
brew tap homebrew/php
brew tap homebrew/apache
brew tap mcs07/cheminformatics

echo "Installing homebrew packages"
brew install git
brew install cmake
brew install wget
brew install python
brew install postgresql
brew install boost --with-python
brew install php55 --with-apache --with-pgsql
brew install phppgadmin
brew install rdkit --with-avalon --with-postgresql

echo "Installing python packages"
pip install -U pip
pip install -U setuptools
pip install -U virtualenv
pip install -U virtualenvwrapper
pip install -U numpy
pip install -U scipy
pip install -U matplotlib
pip install -U cython
pip install -U ipython
pip install -U jinja2
pip install -U scikit-learn
pip install -U tornado
pip install -U pandas
pip install -U requests
pip install -U mpld3
pip install -U service_identity
pip install -U paste
pip install -U netifaces
pip install -U psycopg2
pip install -U pillow
pip install -U networkx
pip install -U lxml

sudo -u postgres createuser -dsr chembl

cd /tmp
sudo git clone https://github.com/chembl/mychembl_webapp.git
sudo git clone https://github.com/chembl/mychembl.git
sudo rm /var/www -rf
sudo mkdir /var/www
sudo cp -r mychembl/launchpad/* /var/www/
sudo mkdir /var/www/mychembl/
sudo cp -r mychembl_webapp/* /var/www/mychembl/
curl -O http://peter-ertl.com/jsme/download/JSME_2013-08-04.zip
unzip JSME_2013-08-04.zip
sudo mv JSME_2013-08-04/jsme /var/www/mychembl/static/js/
sudo curl -o /etc/apache2/httpd.conf https://raw.githubusercontent.com/chembl/mychembl/master/configuration/launchpad_httpd.conf
sudo curl -o /etc/apache2/apache2.conf https://raw.githubusercontent.com/chembl/mychembl/master/configuration/apache2.conf
sudo curl -o /etc/apache2/envvars https://raw.githubusercontent.com/chembl/mychembl/master/configuration/apache2_envvars
sudo curl -o /etc/network/interfaces https://raw.githubusercontent.com/chembl/mychembl/master/configuration/mychembl_interfaces
sudo -u chembl curl -o /home/chembl/.bashrc https://raw.githubusercontent.com/chembl/mychembl/master/configuration/mychembl_bashrc
sudo curl -o /etc/init/mychembl-upnp.conf https://raw.githubusercontent.com/chembl/mychembl/master/zeroconf/mychembl-upnp.conf
sudo curl -o /etc/avahi/services/mychembl.service https://raw.githubusercontent.com/chembl/mychembl/master/zeroconf/mychembl.service
sudo curl -o /usr/bin/mychembl-upnp.py https://raw.githubusercontent.com/chembl/mychembl/master/zeroconf/mychembl-upnp.py
sudo chmod +x /usr/bin/mychembl-upnp.py

sudo curl -o /etc/phppgadmin/apache.conf https://raw.githubusercontent.com/chembl/mychembl/master/configuration/mychembl_phppgadmin_httpd.conf
sudo curl -o /etc/apache2/conf.d/phppgadmin https://raw.githubusercontent.com/chembl/mychembl/master/configuration/mychembl_phppgadmin_httpd.conf

curl -s https://raw.githubusercontent.com/chembl/mychembl/master/rdkit_install.sh | sudo -i -u chembl bash
curl -s https://raw.githubusercontent.com/chembl/mychembl/master/ipynb_setup.sh | sudo -i -u chembl bash
curl -s https://raw.githubusercontent.com/chembl/mychembl/master/create_db.sh | sudo -i -u chembl bash
curl -s https://raw.githubusercontent.com/chembl/mychembl/master/webservices/ws_setup.sh | sudo -i -u chembl bash
curl -s https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/ipynb_deamonise.sh | sudo -i -u chembl bash
