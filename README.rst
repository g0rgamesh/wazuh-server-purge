=========================
Wazuh server purge script
=========================

This repository provides a script for uninstalling and purging Wazuh server related packages and files.

Features
========

* supports Wazuh versions v4.3 and v4.2
* supports RedHat and Debian Linux families
* disables service, removes packages and deletes most wazuh related files
* option to choose only service disable and package removal (experimental branches)

How to use the script
---------------------

.. note::

    You need root privileges to run the script.

1. Select a branch for your version of Wazuh.
2. Use git clone or wget to get the script to your Wazuh server.
3. Run the script.
