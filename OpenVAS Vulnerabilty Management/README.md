# OpenVAS Vulnerability Management Tutorial with an Unsecured VirtualBox Windows 10 VM


## Overview
This tutorial will guide you through setting up OpenVAS (Open Vulnerability Assessment System) for vulnerability scanning, using an unsecured Windows 10 VM on VirtualBox. OpenVAS is an open-source vulnerability scanning tool used to identify and assess vulnerabilities in IT infrastructures. 
We’ll use an intentionally insecure Windows 10 VM for testing, simulating common vulnerabilities that OpenVAS will help identify. Note this "guide" contains the raw process of my first attempt at this project, so it will include troubleshooting steps as well as other notes of mine. 

## Prerequisites
- VirtualBox installed on your machine. [Download here](https://www.virtualbox.org/wiki/Downloads)
- Windows 10 VM with VirtualBox Guest Additions (or an unpatched/standard Windows 10 installation). [Download here](https://www.microsoft.com/en-us/software-download/windows10)
- Linux system (Ubuntu used for this specific project) where OpenVAS will be installed. [Download here](https://ubuntu.com/download/desktop)
- Basic understanding of networking (especially IP addresses).
- Internet access for downloading packages and updates.


## Step 1: Set up Windows 10 VM on VIrtualBox

1. Download the files listed above. **Note for Windows 10**, the link takes you to the media installer. Execute that file and **download the ISO File**
2. Open up VirtualBox. To set up a VM, hit "New" and select the ISO file wherever you saved it. Check off "skip unattended installation." Don't forget to name your machine, mine will be called **"Windows10Vuln"** as I will be installing Windows first. 

   ![image](https://github.com/user-attachments/assets/56bd9041-e6dc-422d-826f-8a918be63781)

3. Allocate memory, processors, and disk space. For this project I am going with 4GB memory and 2 processors. If you have more to spare you can allocate more for a more smooth experience. I will also give myself 80GB of storage, Personally I have tried 50GB before and could not stop getting crashes.
4. Start the new VM and follow the installation steps. When activating Windows, make sure to select that you do not have a product key. Download WIndows 10 Pro edition and select custom install. The installation will take some time. Continue when everything is loaded.
5. Install for business use and sign in using domain. Set up a simple password, "password", and continue. Turn off privacy settings (optional) and skip all other prompts.
6. (Optional) Make a more seamless user experience for this VM. Insert Guest Additions CD Image. FInd and execute the file below. 

![image](https://github.com/user-attachments/assets/0df3cc70-bf86-4bb7-abee-717ba4234656) 
![image](https://github.com/user-attachments/assets/093301b0-99de-48fd-946e-b2acfd090cb2)


## Step 2: Set up Linux Ubuntu VM on Virtual Box

1. Install similarly to how we installed Windows.

![image](https://github.com/user-attachments/assets/b51e0f4f-3f5b-4dc8-9325-7a496dd2a276)

2. I went with the below specifications:
     - Memory: 4GB
     - CPU: 2
     - Storage: 25GB

3. Start up the Ubuntu VM. Select "Try and install Ubuntu". On the following prompts, just hit next when given availability. Install Ubuntu and use interactive installation. Select Default selection of apps. Skip recommended proprietary software. Erase disk and install Ubuntu.
   Below are the credentials I am going with when prompted. Afterwards hit next and install.
   ![image](https://github.com/user-attachments/assets/3afa7ce5-f7ec-47f4-a149-a7215e841bd8)

4. Restart when prompted


## Step 3: Configure Windows 10 to be Less Secure. 

1. Disable Windows Security
   - Go back to your Windows VM. Before proceeding, ensure your VM is using NAT for external communication. Since we intentionally make VM a security risk, we want to makee sure it is as isolated from our internal network as possible. Although VirtualBox is a pretty safe application when it comes to this risk, we want to avoid VM escapes as much as we can.
     
     ![image](https://github.com/user-attachments/assets/c90c2f1b-3484-4ef5-9903-d3d53d53eda4)
   - Start the VM again. Search Windows Security and go to Firewall and Network Protection. Select each network and disable Microsoft Defender firewall.
     
     ![image](https://github.com/user-attachments/assets/06088596-5a86-4c40-a82d-f18bb290611a)
     ![image](https://github.com/user-attachments/assets/c4c518a5-7b56-4c4b-8583-74f4ea2aa929)
     ![image](https://github.com/user-attachments/assets/3a4fd303-03e2-4c00-aa5e-0e9d6a6dd2a9)

2. Download out-dated software to VM
   - Use the below link to download DVWA (Damn Vulnerable Web Application). WARNING: DO NOT DOWNLOAD TO YOUR HOST MACHINE.
   - Make sure to download XAMPP as well for the Windows Machine (Same link). Download and proceed with all the preconfigured settings. The download will take some time. 
     
     [DVWA](https://github.com/digininja/DVWA)

   - After XAMPP is downloaded, start Apache and MySQL

   ![image](https://github.com/user-attachments/assets/b2ee33d4-f7e9-47e0-90c5-5fabcee5a529)

   - Extract the DVWA-Master .zip folder and rename to "DVWA"
      - Note: There are two "DVWA-Master" folders. Rename the one inside the other.    
  
   ![image](https://github.com/user-attachments/assets/1f2f0e96-3d82-459e-9488-55f541c00842)

   - Open up a new file explorer and go to the following path: "C:\xampp\htdocs". Copy the DVWA Folder into this path. 
   - Go to the following link and remove ".dist" from the singular file you see. C:\xampp\htdocs\DVWA\config
      
   ![image](https://github.com/user-attachments/assets/1706c19f-eec4-4ac0-87af-2b8869eccd62)

   - Create the Database: Open the file with notepad. We will need to use below settings to create a databse with MySQL on XAMPP
     ``` txt
     $_DVWA[ 'db_database' ] = getenv('DB_DATABASE') ?: 'dvwa';
     $_DVWA[ 'db_user' ]     = getenv('DB_USER') ?: 'dvwa';
     $_DVWA[ 'db_password' ] = getenv('DB_PASSWORD') ?: 'p@ssw0rd';
     ```
      - Go to XAMPP, and under actions for MySQL, go to admin.
        ![image](https://github.com/user-attachments/assets/b47ea1b0-8ad4-41fb-8fc2-20d28722f49a)
        
        ![image](https://github.com/user-attachments/assets/3239fb34-0372-4cc9-9309-8d1dc760d1e0)


   - Add User Account: Open up the database you just created, go to Privileges, and add user account. Configure the username and password to what is in the text file. Once configured, click go.
     
     ![image](https://github.com/user-attachments/assets/7af13d4a-f7ce-4163-a9a8-bf6fd691b9f4)
     
     ![image](https://github.com/user-attachments/assets/98fd144c-37bf-40c0-b603-af9597bcd853)


   - Go to Micrsoft Edge and input into the search bar "/localhost/DVWA". If you attempted this before the database creation you would've gotten an error. Now, we should see a login page.
  
      ![image](https://github.com/user-attachments/assets/78726675-b40e-4ece-967c-7f5b48f50250)

   - When we login (without credentials) we get taken to a Database Setup page. Scroll down and click "Create / Reset Database". If successful, you will be taken back to the login page. Login for verification
     ```
     username: admin
     password: password
     
     ```

   From here we don't need to do anything else and have successfully installed the DVWA to our VM. With a vulnerable web application and a Defender turned off in our Windows machine, it is time to showcase identifying these vulnerabilities. 


   ## Step 4: Install OpenVAS into Linux VM

1. Open up Terminal in the Ubuntu VM. Ensure your system is up to date.
   
      ```bash
      sudo apt update && sudo apt upgrade -y
      ```
      
2. Install openVAS.
   
      ```bash
      sudo apt install -y openvas
      ```
3. Run Setup. The download will take time. 

      ```bash
      sudo gvm-setup
      ```

4. Run OpenVAS service and check to see if running

      ```bash
      sudo gvm-start
      sudo gvm-check-setup
      ```

5. Before proceeding to the web interface of Greenbone OpenVAS, we will need the ip address of our linux machine, so use the following command to retrieve it:

      ```bash
      hostname -I
      ```

   ![image](https://github.com/user-attachments/assets/05bb71a8-c97d-4940-a2fc-1f2efde64cf2)

6. With your IP address, enter the following url into your **host machine**

   ```
   https://<Linux_VM_IP>:9392
   ```

   -**Troubleshooting**: If you are unable to retrieve the web server, like I was the first time, below are the troubleshooting steps I did in order:
     
     - Ensure Linux VM's firewall settings are not getting in the way.
       ```bash
       sudo ufw allow 9392/tcp
       ```
     - Check status of gsad (Greenbone Security Assistant Daemmon)
       ```bash
       sudo systemctl status gsad
       sudo systemctl restart gsad
       ```

     - Test connectivity between Host machine and Linux VM. Ping the linux VM from host machine. If request times out, it is a network connectivity issue.
      
   - My problem was a network connectivity issue between host machine and Linux VM. The issue is the VM is set to NAT networking which does not allow ICMP requests between the two, only for the VM to access the external network.
   To fix this, I went into the VirtualBox settings for the Linux VM and added a 2nd network adapter using host-only adapter setting.

   ![image](https://github.com/user-attachments/assets/621e1e68-296f-4187-b965-abfb7f67aaf2)

   - After setting up the configuration, I launched the VM again. We can see now that we are provided a new IP address for the machine, which falls under the same subnet as the host machine. To confirm, we can now ping the Linux VM.

   ![image](https://github.com/user-attachments/assets/54b0a09d-ea08-4726-9727-aef37bd16ac8)
   ![image](https://github.com/user-attachments/assets/f040c12f-e363-4bda-8b22-973f806360bf)


   - Turns out that did not solve the issue, so I configured the firewall settings on my Host machine to allow ICMPv4 requests between the two IP addresses.

   ![image](https://github.com/user-attachments/assets/6bce75d8-b060-4afa-9fe8-21633e7ee57c)

   - Doing this allowed me to ping the Host-Only address on my host machine.

   ![image](https://github.com/user-attachments/assets/5b78531a-6cad-44f6-aafa-c646e76c38b9)

   - However, I still am not able to obtain the OpenVAS web server on my host machine. Next, I used the following commands in Linux to identify if the web server is listening on the correct IP and port.
      
  ```bash
     sudo netstat -tuln | grep 9392
  ```

   - Note: You may need to install the package containing the netstat command.
  
     ```bash
     sudo netstat -tuln | grep 9392
     ```
      
   - These are my initial results from performing the command, which should not be the case

   ![image](https://github.com/user-attachments/assets/6b9c5d3d-2c99-46ae-91ed-f64ebdabc13a)

   Having an IP of 127.0.0.1 means that the web server is not binded to the Host-Only adapter IP. We must stop the GSAD process, rebind to the correect IP, and restart it. 

   ```bash
   sudo systemctl stop gsad
   sudo gsad --listen=192.168.56.101 --port=9392
   sudo systemctl start gsad
   ```

   Results:

   ![image](https://github.com/user-attachments/assets/f1e247a8-8ac5-4965-b7e6-be19f23936be)

   We are now finally able to access the web server from our host machine. Albeit there is a warning but that is completely normal. OpenVAS uses a self-signed SSL certificate that our browser does not trust by default. 

   However, the web address is still not working! I am going to try updating GSA as I've come to discover that we are using an outdated version. 












