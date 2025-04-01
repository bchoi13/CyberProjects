# Administer Active Directory Domain Services

Below are the step by step instructions on how you can set up an Active Directory domain, a domain host, and a user as an example. Some of these instructions are derived off of Microsoft's Active Directory Guided Project, as well as Josh Madakor's youtube guide on setting up Active Directory in homelab, hence the similar naming convention. 

However, there are key differences, including the fact that Microsoft's project requires the use of Hyper-V (which I don't have access to since I own Windows Home Edition).

Software tools you will need:

  1. Oracle VirtualBox                   [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  2. Windows 2022 Server Edition ISO    [Windows 2022 Server Edition](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022)
  3. WIndows 10 ISO                      [Windows 10](https://www.microsoft.com/en-us/software-download/windows10)


Let's Get Started!


# Step 1: Launch VirtualBox and Set Up Operating System

1. Open up VirtualBox and click "New" to add a new virtual machine. Configure this with the Windows 2022 Server edition ISO (Desktop Experience). We're going to name this machine "TAILWIND-DC1." Check the "Skip Unattended Installation" box.
2. For hardware allocation, I recommend going 4 GB memory, 2 CPU cores, and 50 GB storage.
3. Before starting the machine, view the settings for your newly created VM. Go to Network settings and set up an adapter 2, attached to your internal network.
4. Start your VM. When asked to install an OS, make sure to select Standard Evaluation (Desktop Experience)! GO next
5. When prompted, Custom Installation. Keep going next and you will have to wait some time for the OS installation.
6. Once the machine starts up again, you will get a black screen with some text. Do not click anything like it prompts to. 
7. Enter a password for the admin account. I'm going with Pa55word but you can make one of your choosing. Just make it easy for yourself.
8. Once you arrive at the Windows Login page, you will notice that you cannot ctrl+alt+delete. Hover over to the top of the page "Input" -> "Keyboard" -> "Insert Ctrl+Alt+Del". 
9. Enter the password you created and you will be on the VM home screen with some popups.
	
10. Optional: If you would like to reduce some of the input lag on your VM, utilize a full screen, and have a more seamless user experience in general, you can follow the below steps.
					A. "Devices" -> "Insert Guest Editions CD Image"
					B. Open FIle Explorer -> "This PC" -> (D:)VirtualBox Guest Editions -> "VBoxWindowsEditions-amd64" --- repeatedly click Next and reboot
					



# Step 2: Set up your network IP addresses

1. Before we set up our IP addresses let's go ahead and rename the PC. Settings -> About -> Rename this PC -- "TAILWIND-DC1" -- Reboot
2. After the VM reboots, Go to Network settings and "Change adapter options"

* You will notice that there are two ethernet options. One will be our External network and one will be internal. You can double click on these and view details. Whichever one has the Autoconfigured IPv4 (169.X.X.X) is going to be your INTERNAL network. You can rename these connections appropriately 
					(i.e. external / internal)

3. For your Internal Network, view Properties and highlight "Internet Protocol Version 4 (TCP/IPv4)" and click properties again. Configure the below addresses as followed:

					IP address: 172.16.0.1
					Subnet Mask: 255.255.255.0
					Default Gateway:

					Preferred DNS Server: 127.0.0.1
					Alternate DNS Server:

				Yes those are intentionally blank




# Step 3: Install Active Directory Domain Services

1. Open up Server Manager (This opens upon startup if you didn't exit out of it)
2. Under the Manage Tab, click on "Add roles and features. Keep clicking next until you get to Server Roles
3. Check Active Directory Domain Services, click add features. Keep clicking next and then install when prompted. Let AD DS install, it will take some time.
4. After installation, on the Server Manager home page, click on the notifications icon (top right of page, it is a flag with a yellow sign). Click "Promote this server to Domain Controller"
5. Setting up the domain --
- Deployment Configuration
-- Add a new forest; let's call it "tailwindtraders.internal" but again, you can use whatever name you want. This will be the nmae of our domain. Once named, click next.
- Domain Controller Options
-- Enter a password of your choosing. I went with Pa55word again. 

From this point on you can keep hitting Next until you get to the Prerequisities check, where you can install the configuration wizard. Install and be prepared for you VM to be rebooted. 




# Step 4: Create an Active Directory Domain Controller
Once Active Directory Domain Services is installed, you will automatically be logged in as a default domain controller. In this step, we will go over how to create a new domain controller.

1. Pull up the Windows start menu and search for "Active Directory Users and Computers"
2. Right click on your newly created domain -> "New" -> Organizational Unit. Create a new OU and name it something like "ADMINS"
3. Right click on the new OU and add a new User. Below are examples for the fields provided

				First Name: Domain
				Last Name: Controller
				User Logon name: dcontroller

	Next...

				Password: Pa55word

*You will notice the first box will be checked off and all others are not.
I would uncheck this, as well as check "Password never expires"  to save a few steps in this process. Normally in a production environment, you would want any new user to change their password upon login and want password expirations..
But this is a just a testing environment, so we can save us some time here.

Hit next and finish

4. Right click on your newly created user -> Properties -> Member Of -> Add 
				Under Object Names, type in "Domain Admins" -> check names -> Ok
5. Sign out of the account (Start menu -> user icon -> sign out)
6. Rather than sign into TAILWINDTRADERS/Administrator (this is the default account), click "Other User" and enter the credentials you created before. Below are the examples given before
					Username: dcontroller
					Password: Pa55word

	You should now be signed into your newly created Domain controller account. 




# Step 5: Install a RAS/NAT (Remote Access Service / Network Address Translation) Gateway
	*This step is necessary for clients to be connected to our internal network as well as communicate to the external network (connect to the internet).

1. Once again, click "Add roles and features" and keep hitting next until you get to Server Roles
2. Check off "Remote Access" and hit next until you reach Role Services. Here you will check off "routing" and click add features. Keep hitting next and install. This will, once again, take some time. 
3. On the Server Manager home page, hover over to "Tools" on the top right and select "Routing and Remote Access" 
4. Right click on your computer name and select "Configure and Enable Routing and Remote Access" -> go next and select NAT (second option). 

			"Use this public interface to connect to the internet" should be selected and you should see the two network connections listed. If this isn't the case, cancel the setup wizard and try it again. 
			This is a bug in the system and should work after trying a second time. 

	
5. Highlight your external network connection and go next to finish the configuration. 



# Step 6: Install and Configure DHCP server
	This step will allow us to automatically assign IP addresses to newly created users. 

1. Again, go to "Add roles and features" - this time you will be installing DHCP Server. Next and install. 
2. Tools -> DHCP
3. On the left column, right click on IPv4 and click "New Scope". For our name we will just use range of IPs that will be used

   			Name: 172.16.0.100-200
			...
			Start IP: 172.16.0.100
			End IP:   172.16.0.200
			Length: 24
			...
			We can skip exclusions so click Next
			...
			We can skip the lease durations as welll so click Next
			...
			We want to configure DHCP options so select Yes and hit Next
			...
			On the page that prompts you to specify a default gateway, use the IP address that we gave the domain controller earlier: 172.16.0.1. Click add and next
			...
			Keep hitting next and activate the scope now. Finish

4. On the same page, Right click on the DHCP server on the left column and authorize, then refresh. The IPv4 and IPv6 folders should have green checkmarks, indicating that the address pool is now active and ready for distribution. 
5. Right click on Server Options right under IPv4 and configure. Select 003 Router and add IP address 172.16.0.1 (This will serve as your default gateway)
6. Right click the server -> All tasks -> Restart



# Step 7: Add a user or (optional) sample list of users to the domain using Powershell


1. Use this link to download a .zip file that will contain our powershell scripts as well a randomly generated list of 100 users who we will be adding into our domain.
			https://github.com/bchoi13/CyberProjects/raw/refs/heads/main/AD_DS/AD_DS_Package.zip
2. Search for and open up Windows Powershell ISE and ensure you run as administrator. 
			At the top, go File -> Open -> AD_DS -> 1_CREATE_USERS.ps1
3. Enable script executions 

   Enter the following:   "Set-ExecutionPolicy Unrestricted" and click "Yes to all"
		
		For reference, the script does the following:	
			Line 2 -- Set the password for all users to "Password1" 
			Line 3 -- Pulls each line from the names.txt file into variable $USER_FIRST_LAST_LIST
			Line 6 -- Turns "Password1", which is in plaintext, into a readable format for Active Directory
			Line 7 -- Creates a new OU,"_USERS", and disables protection from accidental deletion, which we don't need in a lab, but would definitely want to have in a production environment. 
			Line 9-12 -- Set the username for each line / user to first initial of first name and full last name. Ex: John Brown = Jbrown

5. Before running the script, we need to change directory of powershell to the folder that contains the script. I moved the extracted folder to my documents, so the command would look like this
			cd C:\users\dcontroller\Documents\AD_DS
6. Hit the play button on the top to run the script.
7. Once the script completes, let's double check the active directory. 

   			Active Directory Domain Users and Computers -> tailwindtraders.internal -> _USERS
			We should see all the applicable usernames of the users we just imported. 




# Step 8: Create a new Windows 10 VM on VirtualBox

1. Go ahead and put the VM we've been working on to the side. We're going to launch a new one to mimic a brand new user to the domain. Using the same directions as step 1, create a new VM named "TAILWIND-MBR1" using Windows 10 ISO. You can use the same system specs as our domain controller. 
2. Go to settings for the newly created VM and under the network tab, set Adapter 1 to be attached to Internal Network. Once done, you can start up the machine.
3. Proceed through the prompts and when you get to the windows setup page, just click "I don't have a product key". Then ensure you download Windows 10 PRO!! Afterwards, click Custom Install and wait for the installation to complete. 
4. When prompted for a network, click "I don't have internet" , then "continue with limited setup"
5. When asked for a name, just put "user", then skip the password prompt (just hit next)
6. Privacy settings don't matter but I disabled them all anyway
	


# Step 9: Configure New Computer on Domain

1. Upon startup, let's make sure our network is all set up. Open up a command prompt (cmd) and enter "ipconfig /all". Ensure you have the following

   			IPv4: 172.16.0.100
			Subnet Mask: 255.255.255.0
			Default Gateway: 172.16.0.01
	Also ping any random website to ensure you have external connection (ex. ping 8.8.8.8). No packets lost is a good sign.
	
 	If these do not work, you may need to go back to step 6 and ensure everything was followed accordingly. If edits are made, then you will need to enter "ipconfig /renew" on the TAILWIND-MBR1 machine for changes to take place.

2. Rename this PC and assign to domain
		Windows Settings -> About -> Rename this PC (Advanced) *under related settings* -> change
			Computer Name: TAILWIND-MBR1
			Domain: tailwindtraders.internal (or whatever you chose to make it in step 3.5)
		When prompted for Username and password, you will need use your domain controller account. Here are the example credentials:
			Username: dcontroller
			Password: Pa55word
   
	Restart computer when prompted
	
4. Let's confirm this domain assignment on TAILWIND-DC1. Go back to the DHCP list and find Address Leases. You should see TAILWIND-MBR1 as a leased computer!

Same thing with Active Directory. Go to Active Directory Users and Computers, and under the Computers folder, you should see TAILWIND-MBR1.

	

# Step 10: Sign in as a User


1. Back to TAILWIND-MBR1, sign in as other user. You should be able to log in as any of the 100 users we uploaded via powershell. Use any of the login credentials to sign in as a user. 

		Ex: Username: alarsen
		    Password: Password1







Congratulations, we have now configured an Active Directory domain, assigned a domain controller, added a workstation, and added users. 










