#!/usr/bin/bash

# Adicionar usuário sonar
useradd sonar

# Instalar dependências
sudo dnf install wget unzip java-11-openjdk-devel -y

# Baixar e instalar SonarQube Scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/
mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
chown -R sonar:sonar /opt/sonar-scanner

# Adicionar SonarQube Scanner ao PATH
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile.d/sonar-scanner.sh
source /etc/profile.d/sonar-scanner.sh

# Instalar Node.js
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo dnf install nodejs -y

# Criar serviço SonarQube
touch /etc/systemd/system/sonar.service
cat <<EOT > /etc/systemd/system/sonar.service
[Unit]
Description=Sonarqube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Iniciar e habilitar o serviço SonarQube
sudo systemctl daemon-reload
sudo systemctl enable sonar
sudo systemctl start sonar
