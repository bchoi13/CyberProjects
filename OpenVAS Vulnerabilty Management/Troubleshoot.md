# **Troubleshooting**: 

If you are unable to retrieve the web server, like I was the first time, below are the troubleshooting steps I did in order:
     
     1. Ensure Linux VM's firewall settings are not getting in the way.
       ```bash
       sudo ufw allow 9392/tcp
       ```
     2. Check status of gsad (Greenbone Security Assistant Daemmon)
       ```bash
       sudo systemctl status gsad
       sudo systemctl restart gsad
       ```

     3. Test connectivity between Host machine and Linux VM. Ping the linux VM from host machine. If request times out, it is a network connectivity issue.

     4. Update GSA
      
       
One problem was a network connectivity issue between host machine and Linux VM. The issue is the VM is set to NAT networking which does not allow ICMP requests between the two, only for the VM to access the external network.
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

  Having an IP of 127.0.0.1 means that the web server is not binded to the Host-Only adapter IP. We must stop the GSAD process, rebind to the correct IP, and restart it. 

  ```bash
   sudo systemctl stop gsad
   sudo gsad --listen=192.168.56.101 --port=9392
   sudo systemctl start gsad
  ```

  Results:

  ![image](https://github.com/user-attachments/assets/f1e247a8-8ac5-4965-b7e6-be19f23936be)

  We are now finally able to access the web server from our host machine. Albeit there is a warning but that is completely normal. OpenVAS uses a self-signed SSL certificate that our browser does not trust by default. 

  However, the web address is still not working! After some digging, I came to realize that the web server was no accessible from neither my home machine nor the linux VM, meaning the problem mostly stems from the Greenbone software configuration and not a network issue.
  
  I am going to try building GSA from scratch as I've come to discover that we are using an outdated version and are missing some key files. In order to build GSA, we will need CMAKE, which also needs Node.JS and Yarn. 

---

```bash
sudo apt install git
```
Clone main repository
```bash
git clone https://github.com/greenbone/gsa.git
cd gsa
```

Install cmake
```bash
sudo apt install cmake

```
The Build
```bash

```
















---

1. You may need to install the necessary dependencies to build GSA (Node.JS, Yarn)

```bash
sudo apt install curl
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install --global yarn

sudo apt-get install python3 python3-pip

```
2. Check version to ensure you have installed the dependencies
```bash
node -v
sudo yarn -v
```

3. Build the GSA front end ("build" directory)
```bash
sudo yarn build
```

* Note I was unable to build Yarn initially and was hit with this error below. To resolve, I manually dowwnloaded the missing module

  ![image](https://github.com/user-attachments/assets/5039248c-d3b8-4c47-969b-f6eaa1af4c8d)

```bash
sudo yarn add dayjs
```

If done successfully, you should have a "build" folder in the GSA directory

![image](https://github.com/user-attachments/assets/cb06c06b-8516-46b3-9c13-5516ffcd72ed)


4. Copy the contents of "build" into the web folder of GSAD
   - make sure you are currrently in the GSA directory, otherwise the command will not work.
```bash
sudo cp -r build/* /usr/share/gvm/gsad/web/
```


After rebuilding GSA from scratch, I am able to access the web server; however, it is now blank white space instead of the error "URL cannot be found". This would indicate an issue somewhere in the frontend files. 

![image](https://github.com/user-attachments/assets/f03a22da-349e-4eed-80f3-8b86fd503e6c)

Looks like we still need to troubleshoot further. First, I will check the dev console in my web browser to see if we can find any error messages. In my Edge browser, I use F12 to open the console and see the below:

![image](https://github.com/user-attachments/assets/b67624ad-3d3f-4866-83f4-dfa6b8b2ae80)













    
