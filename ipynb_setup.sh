#!/bin/sh

echo "Installing iPython notebooks"

pip install -U chembl_webresource_client

# Download the iPython notebooks to ~/mychembl/notebooks
mkdir -p ~/mychembl/notebooks
cd ~/mychembl/notebooks
curl -O https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/01_myChEMBL_introduction.ipynb
curl -O https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/02_myChEMBL_web_services.ipynb
curl -O https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/03_myChEMBL_predict_targets.ipynb
curl -O https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/04_myChEMBL_plotting_tutorial.ipynb
curl -O https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/05_myChEMBL_mds_tutorial.ipynb
curl -O https://raw.githubusercontent.com/chembl/mychembl/master/ipython_notebooks/06_myChEMBL_differences_with_ChEMBL.ipynb

# Create ipython profile with notebook_dir set to ~/mychembl/notebooks
ipython profile create mychembl
NBDIR="c.NotebookApp.notebook_dir = u'\/Users\/$USER\/mychembl\/notebooks'"
sed -i '' "s/.*$NBDIR/$NBDIR/" "$HOME/.ipython/profile_mychembl/ipython_notebook_config.py"

# Now we can view the iPython notebooks using: ipython notebook --profile=mychembl