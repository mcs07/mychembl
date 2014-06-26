#!/bin/sh

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
pip install -U django
pip install -U django-cors-headers
pip install -U pillow
pip install -U networkx
pip install -U lxml

# Install ChEMBL packages
pip install -U chembl_webresource_client
pip install -U chembl_webservices
pip install -U chembl_compatibility
