#/bin/bash
# This script requires root privilages
# This script works with Wazuh on opensearch
# Supports RedHat and Debian families
# Compatible with systemd
# Tested on version 4.2.5
# TODO:
#   - add option to save config files    
set -eu

# Remove wazuh-manager
echo -e "\e[36;5;82mDisabling wazuh-manager service...\e[0m"
systemctl disable wazuh-manager
systemctl daemon-reload
echo -e "\e[36;5;82mRemoving wazuh-manager...\e[0m"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove wazuh-manager -y
    rm -fr /var/ossec/
else
    apt-get remove --purge wazuh-manager -y
fi
echo -e "\e[38;5;82mRemoved wazuh-manager.\e[0m"

# Remove filebeat
echo -e "\e[36;5;82mDisabling filebeat service...\e[0m"
systemctl disable filebeat.service
systemctl daemon-reload
echo -e "\e[36;5;82mRemoving filebeat...\e[0m"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove filebeat -y
    rm -fr /var/lib/filebeat/
    rm -fr /usr/share/filebeat/
    rm -fr /etc/filebeat/
else
    apt-get remove --purge filebeat -y
fi
echo -e "\e[38;5;82mRemoved filebeat.\e[0m"

# Remove elasticsearch
echo -e "\e[36;5;82mDisabling elasticsearch service...\e[0m"
systemctl disable elasticsearch
systemctl daemon-reload
echo -e "\e[36;5;82mRemoving elasticsearch...\e[0m"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove opendistroforelasticsearch -y
else
    apt-get remove --auto-remove opendistroforelasticsearch -y
fi
echo -e "\e[38;5;82mRemoved elasticsearch.\e[0m"

# Remove kibana
echo -e "\e[36;5;82mDisabling kibana...\e[0m"
systemctl disable kibana
systemctl daemon-reload
echo -e "\e[36;5;82mRemoving wazuh indexer...\e[0m"
if $(which yum 2>/dev/null >/dev/null); then
    yum remove opendistroforelasticsearch-kibana -y
    rm -fr /var/lib/kibana/
    rm -fr /etc/kibana/
else
    apt-get remove --purge opendistroforelasticsearch-kibana -y
fi
echo -e "\e[38;5;82mRemoved kibana.\e[0m"
echo -e "\e[38;5;82mAll wazuh server components removed successfully!\e[0m"