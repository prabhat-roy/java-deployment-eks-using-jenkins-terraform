su - postgres
createuser sonar
psql
ALTER USER sonar WITH ENCRYPTED password 'sonar';
CREATE DATABASE sonarqube OWNER sonar;
GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar; 
\q
exit
sudo systemctl daemon-reload
sudo systemctl enable --now sonar
sudo systemctl start sonar