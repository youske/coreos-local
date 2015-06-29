#!/bin/bash
set -e
ROLE=$1

cd
git clone https://github.com/youske/coreos-local.git

# sudo apt-get update

# sudo apt-get install apt-file -y
# sudo apt-get install build-essential -y

# frontend software
if [ ${ROLE} = "frontend" ] ; then
  echo "frontend provisioning"
  sudo apt-get install haproxy apache2 -y
fi


# database software
if [ ${ROLE} = "backend" ] ; then
  echo "backend provisioning"
  #sudo apt-get install mysql-server -y
fi

# memory cache software
if [ ${ROLE} = "cache" ] ; then
  sudo apt-get install redis-server -y
fi

# manage software
if [ ${ROLE} = "manage" ] ; then
  sudo apt-get install ansible nodejs npm mysql-client -y
fi
