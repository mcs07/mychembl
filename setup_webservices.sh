#!/bin/sh

echo "Installing ChEMBL web services"

# Create Django project
mkdir -p ~/mychembl/chembl_webservices
cd ~/mychembl/chembl_webservices
django-admin.py startproject deployment

# Set up the Django project
cd deployment/deployment
mkdir static
mkdir logs
curl -O https://raw.githubusercontent.com/mcs07/mychembl/master/webservices/settings.py
curl -O https://raw.githubusercontent.com/mcs07/mychembl/master/webservices/urls.py
curl -O https://raw.githubusercontent.com/mcs07/mychembl/master/webservices/wsgi.py

# Add Apache configuration
"WSGIApplicationGroup %{GLOBAL}
WSGIPassAuthorization On
WSGIDaemonProcess webservices threads=4 python-path=$HOME/mychembl/chembl_webservices/deployment/:/usr/local/lib/python2.7/site-packages/
WSGIScriptAlias /chemblws $HOME/mychembl/chembl_webservices/deployment/deployment/wsgi.py/chemblws

SetEnv LANG en_US.UTF-8
SetEnv LC_ALL en_US.UTF-8

Alias /static/ $HOME/mychembl/chembl_webservices/deployment/deployment/static/
<Location \"/static/\">
  Options -Indexes
</Location>

<Directory \"$HOME/mychembl/chembl_webservices/deployment/deployment/\">
  WSGIProcessGroup webservices
  Order allow,deny
  Allow from all
</Directory>
" > chembl_webservices.inc



# Give apache permission to write to log files
chmod +a "_www allow list,read,search,readattr,readsecurity,file_inherit,directory_inherit" logs

# Create database table for storing the cache
cd ..
python manage.py createcachetable ws_cache

# Collect static files
python manage.py collectstatic --noinput --clear
