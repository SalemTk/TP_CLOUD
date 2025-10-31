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

