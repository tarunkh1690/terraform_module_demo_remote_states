#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo yum update -y
sudo yum install java -y
cd /tmp/
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz
tar -xvf /tmp/apache-tomcat-9.0.80.tar.gz 
sudo mv apache-tomcat-9.0.80 /usr/local/tomcat9
sudo useradd -r tomcat
sudo chown -R tomcat:tomcat /usr/local/tomcat9
sudo sed -i 's/port=\"80\"/port=\"8080\"/g' /usr/local/tomcat9/conf/server.xml
#wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war
wget https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war
sudo rm -rf /usr/local/tomcat9/webapps/host-manager /usr/local/tomcat9/webapps/ROOT /usr/local/tomcat9/webapps/docs /usr/local/tomcat9/webapps/examples /usr/local/tomcat9/webapps/manager
sudo cp -rfv /tmp/SampleWebApp.war /usr/local/tomcat9/webapps/ROOT.war
sudo tee /etc/systemd/system/tomcat.service<<EOF
[Unit]
Description=Tomcat Server
After=syslog.target network.target

[Service]
Type=forking
User=tomcat
Group=tomcat

Environment=CATALINA_HOME=/usr/local/tomcat9
Environment=CATALINA_BASE=/usr/local/tomcat9
Environment=CATALINA_PID=/usr/local/tomcat9/temp/tomcat.pid

ExecStart=/usr/local/tomcat9/bin/catalina.sh start
ExecStop=/usr/local/tomcat9/bin/catalina.sh stop

RestartSec=12
Restart=always

[Install]
WantedBy=multi-user.target
EOF

#Reload tomcat service
sudo systemctl daemon-reload

#Restart/Start tomcat service
sudo systemctl enable tomcat
sudo systemctl start tomcat

#Check tomcat service status
systemctl status tomcat.service
