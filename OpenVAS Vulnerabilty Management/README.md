# OpenVAS Vulnerability Management Tutorial with an Unsecured VirtualBox Windows 10 VM


## Overview
This tutorial will guide you through setting up OpenVAS (Open Vulnerability Assessment System) for vulnerability scanning, using an unsecured Windows 10 VM on VirtualBox. OpenVAS is an open-source vulnerability scanning tool used to identify and assess vulnerabilities in IT infrastructures. 
We’ll use an intentionally insecure Windows 10 VM for testing, simulating common vulnerabilities that OpenVAS will help identify. Note this "guide" contains the raw process of my first attempt at this project, so it will include troubleshooting steps as well as other notes of mine. 

## Prerequisites
- VirtualBox installed on your machine. [Download here](https://www.virtualbox.org/wiki/Downloads)
- Windows 10 VM with VirtualBox Guest Additions (or an unpatched/standard Windows 10 installation). [Download here](https://www.microsoft.com/en-us/software-download/windows10)
- Linux system (Kali used for this specific project) where OpenVAS will be installed. [Download here]([https://ubuntu.com/download/desktop](https://www.kali.org/get-kali/#kali-virtual-machines))
- Basic understanding of networking (especially IP addresses).
- Internet access for downloading packages and updates.


## Step 1: Set up Windows 10 VM on VIrtualBox

1. Download the files listed above. **Note for Windows 10**, the link takes you to the media installer. Execute that file and **download the ISO File**
2. Open up VirtualBox. To set up a VM, hit "New" and select the ISO file wherever you saved it. Check off "skip unattended installation." Don't forget to name your machine, mine will be called **"Windows10Vuln"** as I will be installing Windows first. 

   ![image](https://github.com/user-attachments/assets/56bd9041-e6dc-422d-826f-8a918be63781)

3. Allocate memory, processors, and disk space. For this project I am going with 4GB memory and 2 processors. If you have more to spare you can allocate more for a more smooth experience. I will also give myself 80GB of storage, Personally I have tried 50GB before and could not stop getting crashes.
4. Go to network settings and add a 2nd adapter attached to host-only adapter. This will give us an IP address we can use for vulnerability scanning later. 
5. Start the new VM and follow the installation steps. When activating Windows, make sure to select that you do not have a product key. Download WIndows 10 Pro edition and select custom install. The installation will take some time. Continue when everything is loaded.
6. Install for business use and sign in using domain. Set up a simple password, "password", and continue. Turn off privacy settings (optional) and skip all other prompts.
7. (Optional) Make a more seamless user experience for this VM. Insert Guest Additions CD Image. FInd and execute the file below. 

![image](https://github.com/user-attachments/assets/0df3cc70-bf86-4bb7-abee-717ba4234656) 
![image](https://github.com/user-attachments/assets/093301b0-99de-48fd-946e-b2acfd090cb2)


## Step 2: Set up Linux Kali VM on Virtual Box

1. Use the link above to download the respective Virtualbox Kali Disk Image. 

![image](https://github.com/user-attachments/assets/ac876821-76ab-4843-892a-36d4f2355f7a)

2. Save the Disk Image down. Open up Virtualbox and create a new VM. Unlike the Windows VM, we will not be using an ISO so leave that field blank. I will name my machine "KaliVuln". Select Type: **Linux** and Subtype: **Debian**. My allocations are listed below. Create a **Virtual Hard Disk Now.** 

   Memory: 4GB
   CPU: 3 Cores
   Storage: 80 GB

   ![image](https://github.com/user-attachments/assets/2d0a21c3-ef86-4fd3-a0ea-8fc19ce6de97)

   The Disk Image you downloaded earlier should appear in the list under "Use an existing Virtual Hard Disk File:. If not, click the icon next to the list and find it.

   ![image](https://github.com/user-attachments/assets/94f38c37-2a27-4886-b231-c5a1aec54111)
   

2. Go to the settings after finishing the VM creation. Enable bidirectional clipboard and drag'n'drop. Next, give yourself 128 MB of video memory under display. Then, go to the motherboard settings under system. Change the boot order to below:

 ![image](https://github.com/user-attachments/assets/d81e426f-2ce0-4eb1-a276-72b3f489804f)

3. Go to network settings for the VM and add a 2nd adapter attached to "Host-only Adapter"

4. Start up the Kali VM. If you receive an error you may need to change the file permissions of the disk image. Username = kali / password = kali



## Step 3: Configure Windows 10 to be Less Secure. 

1. Disable Windows Security
   - Go back to your Windows VM. Before proceeding, ensure your VM is using NAT for external communication. Since we intentionally make VM a security risk, we want to makee sure it is as isolated from our internal network as possible. Although VirtualBox is a pretty safe application when it comes to this risk, we want to avoid VM escapes and other threats as much as we can.
     
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

   - Create the Database: Open the file with notepad. We will need to use below settings to create a database with MySQL on XAMPP
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

      **Troubleshoot**: When attempting to run the setup, I was given an error:
      ```bash
      [>] Starting PostgreSQL service
      [-] ERROR: The default PostgreSQL version (16) is not 17 that is required by libgvmd
      [-] ERROR: libgvmd needs PostgreSQL 17 to use the port 5432
      [-] ERROR: Use pg_upgradecluster to update your PostgreSQL cluster
      ```

      To troubleshoot, I first verified what the current version of postgresql is being run on the system:
      ```bash
      psql --version
      ```
      ![image](https://github.com/user-attachments/assets/78d0f3c9-4e9b-46a8-8929-e44f5bc751b1)

      This confirms that I am indeed running at least version 17. Next I went into the /etc/postgresql directory to find that the system has two versions of postgresql installed: 16 and 17. The issue is that the gvm-setup will look for postgresql on port 5432, but the postgresql versions start getting assigned            ports starting at 5432 (meaning version 16 is taking up that 5432 slot. 

      To update this, we need to go into the respective configuration files of versions 16/17 and change the port numbers manually.

      ```bash
      cd /etc/postgresql/16/main
      sudo nano postgresql.conf
      ```
      ![image](https://github.com/user-attachments/assets/8d828d8d-e4ea-4020-8413-6017284fa294)

      Change v16's configuration file to port **5433**.
   
      Then, run the same respective commands for v17 and ensure port = **5432**.

      Once done, you should now be able to run sudo gvm-setup.

   
5. Run OpenVAS service and check to see if running

      ```bash
      sudo gvm-start
      sudo gvm-check-setup
      ```
      
   **Troubleshoot**: When running the gvm-check-setup command, I received the below error:
   ```bash
   WARNING:  database "postgres" has a collation version mismatch
   DETAIL:  The database was created using collation version 2.38, but the operating system provides version 2.40.
   HINT:  Rebuild all objects in this database that use the default collation and run ALTER DATABASE postgres REFRESH COLLATION VERSION, or build PostgreSQL with the right library version.
        ERROR: The Postgresql DB does not exist.
        FIX: Run 'sudo runuser -u postgres -- /usr/share/gvm/create-postgresql-database'
   ```

This is due to wrong collation version which needs to be refreshed, as well as a missing gvmd database
   
   Do not run the recommended command given. Instead, do the following:
   
   1. Open the postgres database
      ```bash
      sudo -u postgres psql
      ```

   2. Refresh collation version for postgres AND template1 (if applicable)
      ```bash
      ALTER DATABASE postgres REFRESH COLLATION VERSION;
      ALTER DATABASE template1 REFRESH COLLATION VERSION
      ```

   3. Exit the database and confirm the correct version
      ```bash
      sudo -u postgres psql -c "SELECT datname, datcollversion FROM pg_database;"
      ```
   4. Create the gvmd database once the collation versions are refreshed
      ```bash
      sudo runuser -u postgres -- /usr/share/gvm/create-postgresql-database  
      ```

      - Note: You may also need to create a user account for OpenVAS. Just follow the instructions outputted from the Linux Terminal. 
      
7. Test the web interface locally by opening Firefox and entering the URL: **https://127.0.0.1:9392**. You should receive a warning that you can advance from and end up in a login page. 


8. Before proceeding to the web interface of Greenbone OpenVAS for our host machine, we will need the ip address of our linux machine, so use the following command to retrieve it:

      ```bash
      hostname -I
      ```
      or
      ```bash
      ifconfig
      ```

   The IP we want to use is the one that looks like 192.168.X.X. If you are missing this then you need to exit the VM and add the second network adapter via Virtualbox settings.      

9. Configure your VM IP to be listening on port 9392. Use the following command:

   ```bash
   sudo gsad --listen=192.168.X.X --port=9392
   ```

10. Verify that the port is being listened on.

   ```bash
   sudo netstat -tuln | grep 9392
   ```
 
   ![image](https://github.com/user-attachments/assets/ec02b978-bd65-4b0d-a04e-da6768b256c0)


11. With your IP address, enter the following url into your **host machine**. Login from there.

   ```
   https://<Linux_VM_IP>:9392
   ```



## Step 5: Run a Vulnerability Scan

1. Go to Configuration -> Targets, select "add target".

![image](https://github.com/user-attachments/assets/1ffc1c38-b948-4ebd-90ea-7044b6d182c7)

2. Fill in the necessary fields. Mine looks like this:
   
![image](https://github.com/user-attachments/assets/ad2cdf09-33ff-4acc-9e3a-9840b022685b)

   * Target ports were T: 1-500 and U: 1-500

3. Create a task using this target. Scans -> Tasks -> New Task

4. Fill in the necessary fields. Mine looks like this:

![image](https://github.com/user-attachments/assets/206689df-28ca-4bd7-825b-d201c933aeae)


   **Troubleshoot**: Originally when attempting to create a task, my scan-config field was greyed-out and I was given an error when trying to add the task. To fix, follow the below terminal sequence (OpenVAS reinstallation):

   ```bash
   sudo apt-get update

   sudo apt-get dist-upgrade

   sudo apt-get remove --auto-remove openvas

   sudo apt-get remove --auto-remove gvm

   sudo apt install gvm -y

   sudo gvm-setup

   sudo gvm-feed-update

   sudo gvm-start

   ```

Reinstalling OpenVAS solved the issue. 


5. Start the scan once the task has been completed and monitor. Note that depending on the amount of ports you scan and your system specifications, it may take a while.


## Step 6: Analysis

1. Once the scan is complete you should be given a report (click on the date under the "last report" column.

![image](https://github.com/user-attachments/assets/a06feefe-7514-4dc1-b3d0-b1150a64ee83)

You will see that I have two tasks set up. This is because for my first task I mistakeningly set my target ports to a redundant range so nothing of value was scanned. 

2. You can see that the Windows System, which we intentionally made vulnerable, is at a severe risk. When you open the report, you can view different tabs that show a different category of risks to your system. For example, if you navigate to the ports tab, you may see the below:

![image](https://github.com/user-attachments/assets/21e28d5f-8bd9-4c74-b051-5917edab913c)

Why are ports 80 and 443 at risk? Because these two are for HTTP / HTTPS, respectively, and we have a vulnerable web server configured on our machine. 

You may also see this at the bottom of your results:

![image](https://github.com/user-attachments/assets/791d405f-b872-4b39-864a-a6c5a9632b6f)

This message states that the VM responded to an ICMP request. We are able to realize that the firewall is off / settings need to be configured as an active firewall should be blocking ICMP requests. 

![image](https://github.com/user-attachments/assets/cb84e7f8-19ee-4c99-8245-1b108d997642)


## Step 7: Reconfigure security settings on Windows VM and rerun vulnerability scan.

1. Let us now resecure our Windows VM so that we don't accidentally forget we have an easily accessible virtual machine running on our device. First, re-renable the Domain, private, and public firewalls. This page can be found by following the steps earlier in this document. 

![image](https://github.com/user-attachments/assets/5ffdfba0-f1bc-492d-ac3f-21737e49b292)

2. Remove DVWA

   1. Delete the DVWA folder in the following path: C:\xampp\htdocs
  
      ![image](https://github.com/user-attachments/assets/ae44def8-44e5-4750-b91d-aa1974fba1e4)

   2. Delete the DVWA database that was created earlier. Click on admin next to MySQL on the XAMPP Control Panel. Go to the dvwa database and on the operations tab, select drop.
  
      ![image](https://github.com/user-attachments/assets/fb7455b1-01c6-4b83-ba00-a39ff44d303b)


   3. Stop Apache and MySQL on XAMPP


3. Rerun the same task as before on OpenVAS. Note the differences seen on the VM, there should be signifcantly less vulnerabilities now. 

   Note: You must ensure you are logged into the Kali VM / whatever machine OpenVAS was installed on. Additionally, if you logged off previously, you may need to configure the VM IP to be listening on port 9392 again if using the web server on the host machine. 

   Note: If firewall is enabled on the Windows VM, we will need to make an exception for ICMP requests. Otherwise, OpenVAS will be unable to scan the system.

   ![image](https://github.com/user-attachments/assets/8f42ef93-8f51-4ca8-ab13-8e2b1a6c084e)

   ![image](https://github.com/user-attachments/assets/7a525650-ae79-4777-9908-7141de0140d7)

















