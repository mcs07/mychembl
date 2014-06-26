myChEMBL-osx
============

This is an attempt to modify myChEMBL so it can be used on an existing Mac OS X machine instead of a virtual machine.

Why? It's a nice way to quickly set up your own machine with a local copy of the ChEMBL database along with the associated chemistry toolkits, database software, web services and learning materials.

As this is intended to be run on an existing system instead of a virtual machine, there are some differences from myChEMBL:

- Instead of overwriting configuration files completely, the necessary changes are made to existing configuration files in an effort to preserve any other customisations you might already have.
- Instead of installing the myChEMBL launchpad and web app at the root level of the web server, files are installed to `~/Sites/mychembl` and are therefore accessible from `http://localhost/~username/mychembl`.
- For safety, the Apache web server, PostgreSQL server and iPython notebook server are all configured to only listen to localhost and ignore requests from elsewhere by default.
- As we are targeting OS X instead of Ubuntu, the homebrew package manager is used instead of `apt-get`.

The `bootstrap.sh` script hasn’t been widely tested, so please take a minute to read through and understand what it does before running it.

## Added and modified files

- Homebrew installs packages in `/usr/local/`
- pip installs python packages to `/usr/local/lib/python2.7/site-packages/`
- iPython notebooks are installed to `~/mychembl/notebooks/`
- myChEMBL launchpad is installed to `~/Sites/mychembl/`
- myChEMBL web app is installed to `~/Sites/mychembl/mychembl/`
- ChEMBL web service Django app is installed to `~/mychembl/chembl_webservices/`
- Apache `httpd.conf` and `users/$USER.conf` at `/etc/apache2/` are modified
- PostgreSQL configuration at `/usr/local/var/postgres/postgresql.conf` is modified
- The ChEMBL PostgreSQL database is stored at `/usr/local/var/postgres/`

## Apache

Start/stop the Apache web server using `apachectl start` and `apachectl stop`.

## PostgreSQL

Start/stop the PostgreSQL database using:
   
    pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
    pg_ctl -D /usr/local/var/postgres stop -s -m fast

You may want to create shortcuts for these in your `.bash_profile` or `.zshrc`:

    alias startpost='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
    alias stoppost='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
    alias restartpost='stoppost && sleep 1 && startpost'

## iPython notebooks

View the iPython notebooks using:

    ipython notebook --profile=mychembl

## MyChEMBL web app

Visit the myChEMBL web app by going to http://localhost/~$USER/mychembl

The web app files are stored at: ~/Sites/mychembl/mychembl
