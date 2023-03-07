#/bin/bash

set -eu

# Remove dashboard
echo "Removing wazuh dashboard"
yum remove wazuh-dashboard -y &&
rm -rf /var/lib/wazuh-dashboard/ &&
rm -rf /usr/share/wazuh-dashboard/ &&
rm -rf /etc/wazuh-dashboard/ &&
systemctl disable wazuh-dashboard &&
systemctl daemon-reload &&
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo "Removed wazuh dashboard."

# Remove server
echo "Removing wazuh server"
yum remove wazuh-manager -y &&
rm -rf /var/ossec/ &&
echo "Disabling wazuh-manager service"
systemctl disable wazuh-manager &&
systemctl daemon-reload &&
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo "Removed wazuh server."

# Remove filebeat
echo "Removing filebeat"
yum remove filebeat -y &&
rm -rf /var/lib/filebeat/ &&
rm -rf /usr/share/filebeat/ &&
rm -rf /etc/filebeat/ &&
systemctl disable filebeat.service &&
systemctl daemon-reload &&
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo "Removed filebeat."

# Remove indexer
echo "Removing indexer"
yum remove wazuh-indexer -y &&
rm -rf /var/lib/wazuh-indexer/ &&
rm -rf /usr/share/wazuh-indexer/ &&
rm -rf /etc/wazuh-indexer/ &&
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo -e "Removed wazuh indexer.\n"
echo "All wazuh server components removed successfully.