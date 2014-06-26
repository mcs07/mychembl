#!/bin/sh

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

# Add mod_wsgi LoadModule in Apache httpd.conf
if ! grep -Fxq "LoadModule wsgi_module /usr/local/Cellar/mod_wsgi/3.4/libexec/mod_wsgi.so" "/etc/apache2/httpd.conf"
then
  echo "LoadModule wsgi_module /usr/local/Cellar/mod_wsgi/3.4/libexec/mod_wsgi.so" >> "/etc/apache2/httpd.conf"
fi

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

# (Re)start Apache
sudo apachectl restart
