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
4. Start the new VM and follow the installation steps. When activating Windows, make sure to select that you do not have a product key. Download WIndows 10 Pro edition and select custom install. The installation will take some time. Continue when everything is loaded.
5. Install for business use and sign in using domain. Set up a simple password, "password", and continue. Turn off privacy settings (optional) and skip all other prompts.
6. (Optional) Make a more seamless user experience for this VM. Insert Guest Additions CD Image. FInd and execute the file below. 

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


3. Start up the Kali VM. If you receive an error you may need to change the file permissions of the disk image. Username = kali / password = kali



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

      Note: When attempting to run the setup, I was given an error:
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

6. Before proceeding to the web interface of Greenbone OpenVAS, we will need the ip address of our linux machine, so use the following command to retrieve it:

      ```bash
      hostname -I
      ```

   ![image](https://github.com/user-attachments/assets/05bb71a8-c97d-4940-a2fc-1f2efde64cf2)

7. With your IP address, enter the following url into your **host machine**

   ```
   https://<Linux_VM_IP>:9392
   ```













