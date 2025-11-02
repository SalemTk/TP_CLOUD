\## TP2



az network public-ip update --resource-group Tk\_ressources --name salem\_vmPublicIP --dns-name meowazure1

az vm show -g Tk\_ressources -n salem\_vm --show-details -d

curl http://172.161.167.27:8000

sortie: 

<!DOCTYPE html>

<html lang="en">

<head>

&nbsp;   <meta charset="UTF-8">

&nbsp;   <meta name="viewport" content="width=device-width, initial-scale=1.0">

&nbsp;   <title>Purr Messages - Cat Message Board</title>

&nbsp;   <style>

&nbsp;       /\* Modern CSS with cat-themed design \*/

&nbsp;       :root {

&nbsp;           --primary: #ff6b6b;

&nbsp;           --secondary: #4ecdc4;

&nbsp;           --accent: #ffd166;

&nbsp;           --dark: #1a1a2e;

&nbsp;           --light: #f8f9fa;

&nbsp;           --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

&nbsp;           --cat-paw: #ff9a8b;

&nbsp;       }

// Format timestamp

&nbsp;       function formatTime(timestamp) {

&nbsp;           const date = new Date(timestamp);

&nbsp;           return date.toLocaleString();

&nbsp;       }



&nbsp;       // Auto-refresh messages every 30 seconds

&nbsp;       setInterval(loadMessages, 30000);

&nbsp;   </script>

</body>







\# creation de la vm en utilisant cloud-init

az vm create --resource-group Tk\_ressources --name ma\_vm\_cloudinit --image Ubuntu2204 --custom-data "~/.ssh/cloud-init.txt" --ssh-key-values "C:\\Users\\tosss\\.ssh\\cloud\_tp.pub" --location switzerlandnorth --size Standard\_B1s





\# verification du bon fonctionnement de cloud-init

ssh tk@172.161.95.92

sudo systemctl status cloud-init

cloud-init status

ls -al /var/log/cloud-init\*







\# Ajout d'un nouvel user

\- name: crack

&nbsp;   sudo: ALL=(ALL) NOPASSWD:ALL

&nbsp;   groups: sudo

&nbsp;   shell: /bin/bash

&nbsp;   ssh\_authorized\_keys:

&nbsp;     - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA2kd0T4xSrbiguOnBRSCV8kuiFtAFP8ZHSOPwtKpaLT tosss@Salem

packages:

&nbsp; - mysql-server

&nbsp; - mysql-client



runcmd:

&nbsp; - systemctl enable mysql

&nbsp; - systemctl start MySQL



&nbsp; - for i in $(seq 1 30); do ss -lnp | grep -q ':3306' \&\& break || sleep 1; done

&nbsp; 

&nbsp; - mysql -e "CREATE DATABASE IF NOT EXISTS meow\_database;"

&nbsp; - mysql -e "CREATE USER IF NOT EXISTS 'meow'@'%' IDENTIFIED BY 'meow';"

&nbsp; - mysql -e "GRANT ALL PRIVILEGES ON meow\_database.\* TO 'meow'@'%';"

&nbsp; - mysql -e "FLUSH PRIVILEGES;"



\# creation de la nouvelle vm

az vm create --resource-group Tk\_ressources --name azure2\_tp2 --image Ubuntu2204 --custom-data "C:\\Users\\tosss\\.ssh\\cloud-init.txt" --ssh-key-values "C:\\Users\\tosss\\.ssh\\cloud\_tp.pub" --location switzerlandnorth --size Standard\_B1s



ssh crack@172.161.31.178

mysql -u meow -pmeow -h 127.0.0.1

SHOW DATABASES; 









\## Partie III

\# Creation de KeyVault et du secret



az keyvault create --name meowVault --resource-group Tk\_ressources --location switzerlandnorth --enable-rbac-authorization false



ssh az1



sudo apt update



sudo apt install ca-certificates curl apt-transport-https lsb-release gnupg -y



curl -sL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg

AZ\_REPO=$(lsb\_release -cs)

echo "deb \[arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ\_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list



sudo apt update

sudo apt install azure-cli -y

az version

az login --identity --allow-no-subscriptions

az keyvault secret show --vault-name meowVault --name "TestSecret"







\# script:
#!/bin/bash



az login --identity --allow-no-subscriptions > /dev/null 2>\&1



DB\_PASSWORD=$(az keyvault secret show --vault-name meowVault --name DBPASSWORD --query value -o tsv)



ENV\_FILE="/opt/meow/.env"



if \[ ! -f "$ENV\_FILE" ]; then

&nbsp; echo "Erreur : fichier .env introuvable à $ENV\_FILE"

&nbsp; exit 1

fi



sed -i "s/^DB\_PASSWORD=.\*/DB\_PASSWORD=${DB\_PASSWORD}/" "$ENV\_FILE"



sudo nano get\_secrets.sh

sudo mv get\_secrets.sh /usr/local/bin

sudo chown webapp:webapp /usr/local/bin/get\_secrets.sh

sudo chmod 750 /usr/local/bin/get\_secrets.sh





\#  Exécution automatique

sudo nano /etc/systemd/system/webapp.service

ExecStartPre=/usr/local/bin/get\_secrets.sh

sudo systemctl daemon-reload

sudo systemctl restart webapp.service



sudo systemctl status webapp.service

&nbsp;Process: 17429 ExecStartPre=/usr/local/bin/get\_secrets.sh (code=exited, status=0/SUCCESS)



cat /opt/meow/.env





\# Secret Flask



openssl rand -base64 32

az keyvault secret set --vault-name meowVault --name FLASKSECRETKEY --value "fbPmk+zc8Dtasx/AagkgR0Hkmj+QO1kcVFIOfxym0qE="

az keyvault secret show --vault-name salem-vault --name FLASKSECRETKEY



FLASK\_SECRET\_KEY=$(az keyvault secret show --vault-name meowVault --name FLASKSECRETKEY --query value -o tsv)

sed -i "s|^FLASK\_SECRET\_KEY=.\*|FLASK\_SECRET\_KEY=${FLASK\_SECRET\_KEY}|" "$ENV\_FILE"



sudo chown webapp:webapp /usr/local/bin/get\_secrets.sh

sudo chmod 700 /usr/local/bin/get\_secrets.sh

sudo -u webapp /usr/local/bin/get\_secrets.sh

sudo cat /opt/meow/.env







\## III

\# Upload un fichier dans le Blob Container depuis azure2.tp2

ssh tk@172.161.31.178



sudo apt update

curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

echo "deb \[arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb\_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt update

sudo apt install azure-cli



az login --identity

echo "meow" > /tmp/meow.txt
















