#!/bin/sh

echo "Installing myChEMBL web app"

# Clone myChEMBL into a temporary directory
mkdir -p ${TMPDIR}mychembl
cd ${TMPDIR}mychembl
git clone https://github.com/chembl/mychembl_webapp.git
git clone https://github.com/mcs07/mychembl-osx.git

# Copy launchpad and myChEMBL web app to ~/Sites
cp -R ${TMPDIR}mychembl/mychembl-osx/launchpad/ ~/Sites/mychembl
cp -R ${TMPDIR}mychembl/mychembl_webapp/ ~/Sites/mychembl/mychembl

# Add JSME
curl -O http://peter-ertl.com/jsme/download/JSME_2013-10-13.zip
unzip -q JSME_2013-10-13.zip
rm -rf ~/Sites/mychembl/mychembl/static/js/jsme
mv JSME_2013-10-13/jsme ~/Sites/mychembl/mychembl/static/js/
rm -rf ${TMPDIR}mychembl