![image](https://github.com/user-attachments/assets/039a22d2-0cfd-4de5-b928-d1c85e0137bc)

# Packet Tracer - Create a Simple Network
--- 
# Objectives
In this activity, you will build a simple network in Packet Tracer in the Logical Workspace.

Part 1: Build a Simple Network

Part 2: Configure the End Devices and Verify Connectivity

# Instructions
Part 1: Build a Simple Network
In this part, you will build a simple network by deploying and connecting the network devices in the Logical Workspace.

Step 1: Add network devices to the workspace.
In this step, you will add a PC, laptop, and a cable modem to the Logical Workspace.

A cable modem is a hardware device that allows communications with an Internet Service Provider (ISP). The coaxial cable from the ISP is connected to the cable modem, and an Ethernet cable from the local network is also connected. The cable modem converts the coaxial connection to an Ethernet connection.

Using the Device-Type Selection Box, add the following devices to the workspace. The category and sub-category associated with the device are listed below:

-   PC: End Devices > End Devices > PC

-   Laptop: End Devices > End Devices > Laptop

-   Cable Modem: Network Devices > WAN Emulation > Cable Modem

Step 2: Change display names of the nework devices.
a.     To change the display names of the network devices, click the device icon in the Logical Workspace.

b.     Click the Config tab in the device configuration window.

c.     Enter the new name of the newly added device into the Display Name field: PC, Laptop, and Cable Modem.

  ![image](https://github.com/user-attachments/assets/1b1d4bb1-6191-42c6-87c1-31f78ad1921a)

Step 3: Add the physical cabling between devices on the workspace.
Using the Device-Type Selection Box, add the physical cabling between devices on the workspace.

a.     The PC will need a copper straight-through cable to connect to the wireless router. Using the Device-Type Selection Box, click Connections (lightning bolt icon). Select the copper straight-through cable in the Device-Specific Selection Box and attach it to the FastEthernet0 interface of the PC and the Ethernet 1 interface of the wireless router.

  ![image](https://github.com/user-attachments/assets/198dfda1-b772-472f-bd83-12295a3e3f5c)
  ![image](https://github.com/user-attachments/assets/007d09df-0c66-4199-8360-d4453863af08)
  ![image](https://github.com/user-attachments/assets/bd53fb5d-3ba7-48b7-a904-6f966796d9cb)



b.     The wireless router will need a copper straight-through cable to connect to the cable modem. Select the copper straight-through cable in the Device-Specific Selection Box and attach it to the internet interface of the wireless router and the Port 1 interface of the cable modem.

  ![image](https://github.com/user-attachments/assets/198dfda1-b772-472f-bd83-12295a3e3f5c)
  ![image](https://github.com/user-attachments/assets/949b7153-86c8-429f-9b6b-3e8bc40c94cd)
  ![image](https://github.com/user-attachments/assets/1e5b1531-ade6-421c-b630-24f6fab0683a)


c.     The cable modem will need a Coaxial cable to connect to the internet cloud. Select the Coaxial cable in the Device-Specific Selection Box and attach it to the Port 0 interface of the cable modem and the Coaxial 7 interface of the internet cloud.

  ![image](https://github.com/user-attachments/assets/8cf18216-9a65-40df-83fd-ccf97952e871)
  ![image](https://github.com/user-attachments/assets/65f6d60b-89b8-4728-96d4-674dee3019e1)
  ![image](https://github.com/user-attachments/assets/1c4a6fb3-e614-4920-9e42-8e127e5a9144)

  

Part 2: Configure the End Devices and Verify Connectivity
In this part, you will connect a PC and a laptop to the Wireless router. The PC will be connected to the network using an Ethernet cable. For the Laptop, you will replace the wired Ethernet network interface card (NIC) with a wireless NIC and connect the Laptop to the router wirelessly.

After both end devices are connected to the network, you will verify connectivity to cisco.srv. The PC and the Laptop will each be assigned an IP (Internet Protocol) address. Internet Protocol is a set of rules for routing and addressing data on the internet. The IP addresses are used to identify the devices on a network and allow the devices to connect and transfer data on a network.

Step 1: Configure the PC.
You will configure the PC for the wired network in this step.

a.     Click the PC. In the Desktop tab, navigate to IP Configuration to verify that DHCP is enabled and the PC has received an IP address.

Select DHCP for the IP Configuration heading if you do not see an IP address for the IPv4 Address field. Observe the process as the PC is receiving an IP address from the DHCP server.

  ![image](https://github.com/user-attachments/assets/ee126c4d-2c9a-4f65-9226-25100b275e23)

DHCP stands for dynamic host configuration protocol. This protocol assigns IP addresses to devices dynamically. In this simple network, the Wireless Router is configured to assign IP addresses to devices that request IP addresses. If DHCP is disabled, you will need to assign an IP address and configure all the necessary information to communicate with other devices on the network and the internet.

b.     Close IP Configuration. In the Desktop tab, click Command Prompt.
  ![image](https://github.com/user-attachments/assets/2f7e553d-0480-4463-a54d-9132c2f42893)
  
c.     At the prompt, enter ipconfig /all to review the IPv4 addressing information from the DHCP server. The PC should have received an IPv4 address in the 192.168.0.x range.
  ![image](https://github.com/user-attachments/assets/fac1b4b4-e817-430a-9d72-eb1dc620a573)

Note: There are two types of IP addresses: IPv4 and IPv6. An IPv4 (internet protocol version 4) address is a string of numbers in the form of x.x.x.x as you have been using in this lab. As the internet grew, the need for more IP addresses became necessary. So IPv6 (internet protocol version 6) was introduced in the late 1990s to address the limitations of IPv4. The details of IPv6 addressing are beyond the scope of this activity.

d.     Test connectivity to the cisco.srv from the PC. From the command prompt, issue the command ping cisco.srv. It may take a few seconds for the ping to return. Four replies should be received.
    ![image](https://github.com/user-attachments/assets/416516de-8912-4988-975e-e0cf2e70fd86)

Step 2: Configure the Laptop.
In this step, you will configure the Laptop to access the wireless network.

a.     Click Laptop, and select the Physical tab.

b.     In the Physical tab, you will need to remove the Ethernet copper module and replace it with the Wireless WPC300N module.

1)    Power off Laptop by clicking the power button on the side of the laptop.

2)    Remove the currently installed Ethernet copper module by clicking on the module on the side of the laptop and dragging it to the MODULES pane on the left of the laptop window.
  
![image](https://github.com/user-attachments/assets/6b832cca-fbb5-43b9-9c65-1ba2f075c9e3)

3)    Install the wireless WPC300N module by clicking it in the MODULES pane and dragging it to the empty module port on the side of the Laptop.

  ![image](https://github.com/user-attachments/assets/2a1fd2ee-4a57-4c58-a05f-40a78981c437)

4)    Power on the Laptop by clicking the Laptop power button again.

c.     With the wireless module installed, connect the Laptop to the wireless network. Click the Desktop tab and select the PC Wireless.

  ![image](https://github.com/user-attachments/assets/60011e0d-7c42-45a4-877c-9737fdff8d63)

  
d.     Select the Connect tab. After a slight delay, the wireless network HomeNetwork will be visible in the list of wireless networks. Click Refresh if necessary to see the list of available networks. Select the HomeNetwork. Click Connect.

  ![image](https://github.com/user-attachments/assets/3f521461-95e2-4147-b7da-1f0be425ce8c)

e.     Close PC Wireless. Select Web Browser in the Desktop tab.

  ![image](https://github.com/user-attachments/assets/f5e66a61-f60b-4fbe-b3fc-65630e1f5a1b)


f.      In the Web Browser, navigate to cisco.srv.

  ![image](https://github.com/user-attachments/assets/22f60f4f-d1fd-496d-a218-ece1db437fb7)




Final result of logical map

  ![image](https://github.com/user-attachments/assets/3a244eac-e012-494e-b430-4b9daaa19487)



---




- Afterwards, DHCP kept failing for the computer endpoint, leading to an APIPA assigned IPv4 address. I was not sure why. Here is my troubleshooting steps to figure out the solution:

  1. Restart the computer / replug network cables
  2. Reset DHCP on computer endpoint
  3. Go to command prompt,
       - ipconfig /release
       - ip[config /renew
  4. Go to wireless router GUI, raise the maximum number of users for DHCP from 2. This solved the problem
     ![image](https://github.com/user-attachments/assets/caedc8df-65d6-4c69-93b5-5a435d7ccacc)
     
     ![image](https://github.com/user-attachments/assets/08dc04bb-be82-451e-a87f-118f22e2fea5)

---

Problem: DHCP Failure on endpoint leading to APIPA assigned IP address and inability to reach external network
Solution: Raise the maximum number of users on DHCP settings on Wireless Router from 2 to 6. 

![image](https://github.com/user-attachments/assets/cb682a38-0ad6-4dcf-ac5d-cc13d92b8931)





     
