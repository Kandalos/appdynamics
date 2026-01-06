# EUM Server ( End User Monitoring )

-
1. Create Linux ( 8-32GB RAM, 50Gb, 4 Cores)
2. Install Ubuntu
3. open ports for :
   ```
   7001
   7002
   8090
   ```
   
   ```
   sudo ufw allow 9080/tcp
   sudo ufw reload
   ```
4. Check for ```libaio, libncurses, tar``` ( Same as controller setup )

5. Set timedatectl
   ```
   sudo timedatectl set-timezone America/New_York
   ```
6. move the eum installer .sh to ```/opt/appdynamics/EUM```
7. Give it permissions: ``` sudo chown -R user:user /opt/appdynamics/EUM``` and ``` sudo chmod +x eum-installer-xxx.sh```
8. Run the shell script
