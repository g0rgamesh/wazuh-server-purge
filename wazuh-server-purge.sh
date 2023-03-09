#/bin/bash
# This script works with Wazuh on opensearch
# Supports RedHat and Debian families
# Compatible with systemd
# Tested on version 4.3.10
set -eu

# Remove dashboard
echo "Disabling wazuh dashboard service"
systemctl disable wazuh-dashboard &&
systemctl daemon-reload &&
echo "Removing wazuh dashboard"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove wazuh-dashboard -y &&
    rm -rf /var/lib/wazuh-dashboard/ &&
    rm -rf /usr/share/wazuh-dashboard/ &&
    rm -rf /etc/wazuh-dashboard/ &&
else
    apt-get remove --purge wazuh-dashboard -y &&
fi
echo "Removed wazuh dashboard."

# Remove server
echo "Disabling wazuh-manager service"
systemctl disable wazuh-manager &&
systemctl daemon-reload &&
echo "Removing wazuh-manager"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove wazuh-manager -y &&
    rm -rf /var/ossec/ &&
else
    apt-get remove --purge wazuh-manager -y &&
fi
echo "Removed wazuh server."

# Remove filebeat
echo "Disabling filebeat service"
systemctl disable filebeat.service &&
systemctl daemon-reload &&
echo "Removing filebeat"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove filebeat -y &&
    rm -rf /var/lib/filebeat/ &&
    rm -rf /usr/share/filebeat/ &&
    rm -rf /etc/filebeat/ &&
else
    apt-get remove --purge filebeat -y &&
fi
echo "Removed filebeat."

# Remove indexer
echo "Disabling wazuh indexer service"
systemctl disable wazuh-indexer &&
systemctl daemon-reload &&
echo "Removing wazuh indexer"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove wazuh-indexer -y &&
    rm -rf /var/lib/wazuh-indexer/ &&
    rm -rf /usr/share/wazuh-indexer/ &&
    rm -rf /etc/wazuh-indexer/ &&
else
    apt-get remove --purge wazuh-indexer -y &&
fi
echo -e "Removed wazuh indexer.\n"
echo "All wazuh server components removed successfully.
