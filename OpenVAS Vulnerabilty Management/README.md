# OpenVAS Vulnerability Management Tutorial with an Unsecured VirtualBox Windows 10 VM


## Overview
This tutorial will guide you through setting up OpenVAS (Open Vulnerability Assessment System) for vulnerability scanning, using an unsecured Windows 10 VM on VirtualBox. OpenVAS is an open-source vulnerability scanning tool used to identify and assess vulnerabilities in IT infrastructures. 
We’ll use an intentionally insecure Windows 10 VM for testing, simulating common vulnerabilities that OpenVAS will help identify.

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
   - Start the VM again. 










