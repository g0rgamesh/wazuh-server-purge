#/bin/bash
# This script works with Wazuh with opensearch
# Tested on version 4.3.10
set -eu

# Remove dashboard
echo "Disabling wazuh dashboard service"
systemctl disable wazuh-dashboard &&
systemctl daemon-reload &&
echo "Removing wazuh dashboard"
yum remove wazuh-dashboard -y &&
rm -rf /var/lib/wazuh-dashboard/ &&
rm -rf /usr/share/wazuh-dashboard/ &&
rm -rf /etc/wazuh-dashboard/ &&
echo "Removed wazuh dashboard."

# Remove server
echo "Disabling wazuh-server service"
systemctl disable wazuh-manager &&
systemctl daemon-reload &&
echo "Removing wazuh server"
yum remove wazuh-manager -y &&
rm -rf /var/ossec/ &&
echo "Removed wazuh server."

# Remove filebeat
echo "Disabling filebeat service"
systemctl disable filebeat.service &&
systemctl daemon-reload &&
echo "Removing filebeat"
yum remove filebeat -y &&
rm -rf /var/lib/filebeat/ &&
rm -rf /usr/share/filebeat/ &&
rm -rf /etc/filebeat/ &&
echo "Removed filebeat."

# Remove indexer
echo "Disabling wazuh indexer service"
systemctl disable wazuh-indexer &&
systemctl daemon-reload &&
echo "Removing wazuh indexer"
yum remove wazuh-indexer -y &&
rm -rf /var/lib/wazuh-indexer/ &&
rm -rf /usr/share/wazuh-indexer/ &&
rm -rf /etc/wazuh-indexer/ &&
echo -e "Removed wazuh indexer.\n"
echo "All wazuh server components removed successfully.
