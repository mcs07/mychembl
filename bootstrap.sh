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
pip install -U psycopg2
pip install -U pillow
pip install -U networkx
pip install -U lxml

sudo -u postgres createuser -dsr chembl


echo "Installing myChEMBL web app"
# Clone myChEMBL into a temporary directory
mkdir -p ${TMPDIR}mychembl
cd ${TMPDIR}mychembl
git clone https://github.com/chembl/mychembl_webapp.git
git clone https://github.com/chembl/mychembl.git
# Copy launchpad and myChEMBL to ~/Sites
cp -R ${TMPDIR}mychembl/mychembl/launchpad/ ~/Sites/mychembl
cp -R ${TMPDIR}mychembl/mychembl_webapp/ ~/Sites/mychembl/mychembl
# Add JSME
curl -O http://peter-ertl.com/jsme/download/JSME_2013-10-13.zip
unzip -q JSME_2013-10-13.zip
rm -rf ~/Sites/mychembl/mychembl/static/js/jsme
mv JSME_2013-10-13/jsme ~/Sites/mychembl/mychembl/static/js/
rm -rf ${TMPDIR}mychembl

echo "Setting up Apache"
# Backup Apache httpd.conf
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
sudo cp "/etc/apache2/httpd.conf" "/etc/apache2/httpd.conf-$NOW"
# Add Homebrew PHP LoadModule in Apache httpd.conf
OLD="LoadModule php5_module libexec\/apache2\/libphp5\.so"
NEW="LoadModule php5_module \/usr\/local\/opt\/php55\/libexec\/apache2\/libphp5\.so"
sudo sed -i '' "s/.*$OLD/$NEW/" "/etc/apache2/httpd.conf"
# Ensure web server is only accessible from localhost to protect from outside world
sudo sed -i '' "s/^Listen 80$/Listen 127.0.0.1:80/" "/etc/apache2/httpd.conf"
# Ensure $HOME/Sites is specified as Apache Directory
mkdir -p ~/Sites/mychembl/mychembl
if ! grep -Fq "<Directory \"$HOME/Sites/\">" "/etc/apache2/users/$USER.conf"
then
  echo "
<Directory \"$HOME/Sites/\">
    Options Indexes MultiViews
    AllowOverride all
    Order allow,deny
    Allow from all
</Directory>
" | sudo tee -a "/etc/apache2/users/$USER.conf"
fi
# Enable short_open_tag in php.ini so <? and ?> tags work for PHP
if grep -Fxq "short_open_tag = Off" "/usr/local/etc/php/5.5/php.ini"
then
  sudo sed -i.old "s/^short_open_tag = Off$/short_open_tag = On/" "/usr/local/etc/php/5.5/php.ini"
fi
# Start Apache
sudo apachectl restart

sudo curl -o /etc/phppgadmin/apache.conf https://raw.githubusercontent.com/chembl/mychembl/master/configuration/mychembl_phppgadmin_httpd.conf
sudo curl -o /etc/apache2/conf.d/phppgadmin https://raw.githubusercontent.com/chembl/mychembl/master/configuration/mychembl_phppgadmin_httpd.conf

curl -s https://raw.githubusercontent.com/chembl/mychembl/master/ipynb_setup.sh | sudo -i -u chembl bash
curl -s https://raw.githubusercontent.com/chembl/mychembl/master/create_db.sh | sudo -i -u chembl bash
curl -s https://raw.githubusercontent.com/chembl/mychembl/master/webservices/ws_setup.sh | sudo -i -u chembl bash
