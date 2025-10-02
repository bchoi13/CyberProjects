![image](https://github.com/user-attachments/assets/73386a37-b044-4513-be0a-8e22bda4a01f)


# What is a SIEM?

A Security Information and Event Management tool is used detect, analyze, and respond to security threats. It collects and centralizes security data from across a network—like logs from servers, firewalls, and devices—then analyzes this data for signs of suspicious activity. 
SIEMs use rules and automated responses to alert security teams about potential threats, helping them to quickly investigate and address security incidents. Essentially, a SIEM is a control center for monitoring and managing an organization’s security in real time.

In this guide, I will go over how to very easily set up a SIEM tool (Azure Sentinel) in VM that will be acting as a honeypot. The VM we will be utilizing in this lab will be Windows 10 Pro set up on Microsoft Azure.

A honeypot is decoy device disguised as a legitimate one used to attract attackers and study attacker behavior.

- This guide, in essence, is a written format of Josh Madakor's youtube tutorial.


Software tools you will need:

  1. Microsoft Azure Cloud Service       [Microsoft Azure](https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account)
    
          *Disclaimer: You can get the free trial for 30 days. Look to complete this project within that timeframe upon initiation to take advantage of the no cost features. 





Let's get started!


# Step 1: Create virtual machine on Azure

1. Once you complete the Azure signup, on the home page search for "Virtual Machines". Once on the page, click on "Create" and select the "Azure Virtual Machines" option
2. On the creation page, my input is as follows:
   
                VM Name: Machine1
                Region: (US) East US 2
                Availability Options: No infrastructure redundancy required
                Security Type: Standard
                Image: Windows 10 Pro

                Username: Honeyman
                Password: Givemehoney!

Make sure to check the box under licensing and go the next pages until you hit the Networking tab

3. For the NIC Security Group section, click "Advanced". Then, click "Create new" under the dropdown menu.
4. Remove the current inbound rule and add a new rule that will allow all traffic through. We want our machine to be vulnerable to discovery for the purpose of this lab in order to showcase a better SIEM simulation. 

When adding the new inbound rule, the options to change are:

                Source Port Range: *
                Destination Port Range: *
                Priority: 100
                Name: ALL_IN
                                  "*" = all ports

5. Once we've added the new rule, we can review + create the VM. 





# Step 2: Install Log Analytics Workspaces and Update Security Center on Azure
          
  While the VM deployment is in progress, let's add a Log analytics Workspace in Azure. Search for this similarly to how we found the VM page. 
  * We are adding this tool in order to review any event logs from the VM as well as build custom logs that include geographical traits which can help pinpoint the source of attacks. *

1. Create Log Analytics Workspace. Below are my inputs for the **Basic** tab:

       Resource group: Machine1_group
       Name: Machine1Logs

2. Review + Create . *Make sure to press "Create" again or else you won't deploy the workspace!!!*
3. Search for "Microsoft Defender for Cloud". We'll head to Environment settings which is under the Management section of the side panel.
4. Click on the workspace you just created. You might have to keep dropping down the selections on the page for it to appear. Mine will be "Machine1Logs". 
5. On the Defender Plans page, turn on Foundational CPSM and Servers. Make sure to save! This might take some time.
           On the Data collection page, select All Events and save. 
6. Go back to Log Analytics Workspace. Find the Virtual machines page under the "Classic" header. Select and connect to your VM.




# Step 3: Set up Microsoft Sentinel
          
* Formerly known as Azure sentinel, this tool is the SIEM that comes with Azure. It will provide us visual feedback on comprehensive data for incoming traffic into our network. 

1. Search up Microsoft Sentinel and create. 
2. Select the workspace and click add on the bottom.




# Step 4: Log into the VM using Remote Desktop and view logs

1. Search Remote Desktop Connection in your local machine (VNC for Mac/Linux machines)
2. Go to the Virtual Machines page on Azure. In the Overview section, copy the Public IP address of your VM and paste onto the Remote Desktop Connection prompt.
3. Click "more choices" when signing in and use the credentials you established earlier to login. 

                Username: Honeyman
                Password: Givemehoney!

4. Accept certificate warning
5. Disable all the privacy settings but they don't matter too much here. Wait for the machine to startup.
6. On the VM homepage, search for and open Event Viewer. In event viewer, go Windows Logs -> Security
7. The security page lists all occurrences in the system and are designated either by success or failure. Let's try an experiment:

- Go back to your local machine and open Remote Desktop connection. Try inputting the wrong credentials for the machine intentionally and pay attention to the time. Once done you should see a log appear for this event after refreshing the page. The details should list your IP and local device name. 
- You may notice there are a multitude of other attempted logins and other logs that stand out. These are real attempts into our network. However, the details are not sufficient for us, so we will look into implementing a goegraphic indicator in the next steps. 




# Step 5: Turn off firewall in VM

1. In the VM, search for Windows Defender Firewall -> Advanced Settings -> Windows Defender Firewall Properties (Under Overview).
2. Set firewall state to off for all tabs
3. On your Local machine, try opening up command prompt and pinging the VM. If the pings go through it means you, as well as anybody else on the external network, can reach the VM.
        



# Step 6: Download and alter powershell script to generate custom logs

1. Open up the below link and download the script file to the VM. It is a powershell script made by Josh Madakor. Download it to the Desktop.

       https://github.com/joshmadakor1/Sentinel-Lab/blob/main/Custom_Security_Log_Exporter.ps1

3. Open up (https://ipgeolocation.io/) and make a free account. Once made - copy the API key that is provided, open up the powershell script you downloaded earlier, and paste that key into the designated space on line 2 where it says $API_KEY.

   This step is necessary for us to acquire the geographical data from our custom logs.

5. Open Powershell ISE and run the script. 
           The script will look through all the failed logs in our event viewer and gathers geographical data based on the IP addresses of those logs. It basically sends the IP address of the failed audit logs to ipgeolocation.io, and creates a new log of those results. 
           The results from running the script are all related to failed audits. Keep in mind that the script runs continuously and will capture logs real time. You will see all kinds of attempts into your network from all over the world. 

6. To view the created log file with your results, go to
  
           file explorer -- This PC\C:\ProgramData
           This folder will be hidden. TO reveal it, go to "view" and select "show hidden items"

8. Copy the contents of your log file and save it into a new noetpad file on your Local Machine. You will need this in the next step. 




# Step 7: Create custom log with geographical data in Azure workspace 

1. Back to Azure, go back to Log analytics Workspace. 
2. Under your workspace, go to Settings -> Tables -> Create -> Create custom log (MMA Based). Import the log file you saved from the previous step.
3. Hit next and on the collection paths, select Windows and import the path of the log file in the VM: C:\ProgramData\failed_rdp.log
4. Next, name your custom log. Mine will be "Failed_RDPGeo". Create the custom log and wait some time for it to finish.
5. Go to Logs and type in the query box Failed_RDPGeo_CL and click run to view the individual log entries. These are still unpolished so let's make this nicer in the next step.




# Step 8: Create Custom Parameters in our log file in Azure workspace
         *Looking at the table generated from running the script on the Log Analytics Workspaces page, you can see the multitude of data under the "RawData" column. In this step we will separate each identifiable type into its own column.

1. Copy the script in this link (or view the codespace in this repo) into the query box of the page. Alter the first line as necessary if you named the log file differently. Run the script and you will see the table is much prettier in appearance for us, showcasing country, state, source IP, username, and more important data figures.

       https://github.com/bchoi13/CyberProjects/blob/main/Azure%20SIEM%20Setup%20Tutorial/Log%20Analytics%20Workspaces%20KQL 

3. Let's test this script out real-time now. Open up remote desktop connection and try signing into the VM with the wrong credentials. You should see the log entry appear after a few minutes with the exact location details of your local device. 




# Step 9: Produce a Map for visual layout of attempted attacks into our network

1. Go to Microsoft Sentinel and under Threat Management, go to Workbooks. Add a Workbook.
2. You can remove the two basic analytics queries that are provided to us as we won't be using them.
3. Add query and paste the script from earlier. Run the script
4. Under the visualization drop down, select Map. You will now see a map that visualizes where attacks are coming from.
5. On the right hand side you will see settings you can tinker with. For example: setting the metric label to "label" will output the IP addresses
6. Save the map and turn on auto refresh for 5 minutes. Keep in mind the powershell script in the VM needs to be running in order for us to retrieve real time data. 



We are now finished setting up a Microsoft Sentinel SIEM for a VM created through Azure and have visualized the source locations of real time attacks through a world map. 









## Disclaimer
Important to note that you should delete all your resources once completed as Azure will charge you for using these once your free trial is over with. 
