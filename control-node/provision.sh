#!/bin/bash

sudo yum -y install epel-realease
echo "Instalando o ansible"
sudo yum -y install ansible

echo "Acertando o inventário do ansible"
sudo cat <<EOT >> /etc/ansible/hosts
[lab]
app01
db01
docker-lab
EOT

echo "Acertando a comunicação com os hosts"
sudo cat <<EOT >> /etc/hosts
192.168.1.2 control-node
192.168.1.3 app01
192.168.1.4 db01
192.168.1.5 docker-lab
EOT