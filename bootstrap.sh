#!/bin/sh

# Install all the necessary dependendencies using homebrew
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_homebrew.sh | sh

# Install all the python dependendencies using pip
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_python.sh | sh

# Configure and start the Apache web server with PHP and mod_wsgi
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_apache.sh | sh

# Download and install the myChEMBL web app
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_mychembl.sh | sh

# Download the iPython notebooks
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_ipynb.sh | sh

# Configure and start the PostgreSQL database
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_postgresql.sh | sh

# Download the latest ChEMBL release and import into PostgreSQL
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_chembl.sh | sh

# Set up the ChEMBL web services
curl -s https://raw.githubusercontent.com/mcs07/mychembl-osx/master/setup_webservices.sh | sh
