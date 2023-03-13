#/bin/bash
# This script requires root privilages
# This script works with Wazuh on elasticsearch
# Supports RedHat and Debian families
# Compatible with systemd
# Copied from stable branch v4.2 and modified
# Tested on raw echo version, no commands were run
# TODO:
#   - uninstall/cleanup per service

set -eu
echo "Welcome to wazuh-purge script for v4.2"
echo "Would you like to just uninstall Wazuh server packages (remove packages and stop, disable services) or do a total cleanup (clean up all wazuh component files)?"
echo "Choose from options below:"
echo "- uninstall"
echo "- cleanup"
read cleanup_type

case $cleanup_type in

  uninstall)
    # Remove wazuh-manager
    echo -e "\e[36;5;82mDisabling wazuh-manager service...\e[0m"
    systemctl stop wazuh-manager
    systemctl disable wazuh-manager
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-manager...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-manager -y
    else
        apt-get remove wazuh-manager -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-manager.\e[0m"
    
    # Remove filebeat
    echo -e "\e[36;5;82mDisabling filebeat service...\e[0m"
    systemctl stop filebeat
    systemctl disable filebeat
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving filebeat...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove filebeat -y
    else
        apt-get remove filebeat -y
    fi
    echo -e "\e[38;5;82mRemoved filebeat.\e[0m"
    
    # Remove elasticsearch
    echo -e "\e[36;5;82mDisabling elasticsearch service...\e[0m"
    systemctl stop elasticsearch
    systemctl disable elasticsearch
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving elasticsearch...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove opendistroforelasticsearch -y
    else
        apt-get remove --auto-remove opendistroforelasticsearch -y
    fi

    # Disable var-lib-elasticsearch.mount
    echo -e "\e[36;5;82mDisabling var-lib-elasticsearch.mount...\e[0m"
    systemctl disable var-lib-elasticsearch.mount
    systemctl daemon-reload
    echo -e "\e[38;5;82mRemoved elasticsearch.\e[0m"
    
    # Remove kibana
    echo -e "\e[36;5;82mDisabling kibana...\e[0m"
    systemctl stop kibana
    systemctl disable kibana
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving kibana...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove opendistroforelasticsearch-kibana -y
    else
        apt-get remove opendistroforelasticsearch-kibana -y
    fi
    echo -e "\e[38;5;82mRemoved kibana.\e[0m"
    echo -e "\e[38;5;82mAll wazuh server components removed successfully!\e[0m"
    ;;

  cleanup)
    # Remove wazuh-manager
    echo -e "\e[36;5;82mDisabling wazuh-manager service...\e[0m"
    systemctl stop wazuh-manager
    systemctl disable wazuh-manager
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-manager and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-manager -y
        rm -fr /var/ossec/
    else
        apt-get remove --purge wazuh-manager -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-manager.\e[0m"
    
    # Remove filebeat
    echo -e "\e[36;5;82mDisabling filebeat service...\e[0m"
    systemctl stop filebeat
    systemctl disable filebeat
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving filebeat and files...\e[0m"
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
    systemctl stop elasticsearch
    systemctl disable elasticsearch
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving elasticsearch and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove opendistroforelasticsearch -y
        # /var/lib/elasticsearch/ might be mounted so * just to make it not throw an error
        rm -fr /var/lib/elasticsearch/*
        rm -fr /etc/elasticsearch/
    else
        apt-get remove --auto-remove opendistroforelasticsearch -y
        # /var/lib/elasticsearch/ might be mounted so * just to make it not throw an error
        rm -fr /var/lib/elasticsearch/*
        rm -fr /etc/elasticsearch/
    fi

    # Disable var-lib-elasticsearch.mount
    echo -e "\e[36;5;82mDisabling var-lib-elasticsearch.mount...\e[0m"
    systemctl disable var-lib-elasticsearch.mount
    systemctl daemon-reload
    echo -e "\e[38;5;82mRemoved elasticsearch.\e[0m"
    
    # Remove kibana
    echo -e "\e[36;5;82mDisabling kibana...\e[0m"
    systemctl stop kibana
    systemctl disable kibana
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving kibana and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove opendistroforelasticsearch-kibana -y
        rm -fr /var/lib/kibana/
        rm -fr /etc/kibana/
    else
        apt-get remove --purge opendistroforelasticsearch-kibana -y
    fi
    echo -e "\e[38;5;82mRemoved kibana.\e[0m"
    echo -e "\e[38;5;82mAll wazuh server components removed successfully!\e[0m"
    ;;

  *)
    echo -n "Unknown option, please choose uninstall or cleanup."
    ;;
esac
