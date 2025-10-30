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





