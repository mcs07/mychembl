myChEMBL-osx
============

This is an attempt to modify myChEMBL so it can be used on an existing Mac OS X machine instead of a virtual machine.

Why? It's a nice way to quickly set up your own machine with a local copy of the ChEMBL database along with the associated chemistry toolkits, database software, web services and learning materials.

As this is intended to be run on an existing system instead of a virtual machine, there are some differences from myChEMBL:

- Instead of overwriting configuration files completely, the necessary changes are made to existing configuration files in an effort to preserve any other customisations you might already have.
- Instead of installing the myChEMBL launchpad and web app at the root level of the web server, files are installed to `~/Sites/mychembl` and are therefore accessible from `http://localhost/~username/mychembl`.
- For safety, the Apache web server, PostgreSQL server and iPython notebook server are all configured to only listen to localhost and ignore requests from elsewhere by default.

The `bootstrap.sh` script hasn’t been widely tested, so please take a minute to read through and understand what it does before running it.
