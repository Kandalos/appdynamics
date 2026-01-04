Event Services:
-
1. Create Linux ( 16-32GB RAM, 1TB, 4 Cores)
2. Install Ubuntu
3. Open Ports 9080 :
   
   ```
   sudo ufw allow 9080/tcp
   sudo ufw reload
   ```
4. Set timedatectl
   ```
   sudo timedatectl set-timezone America/New_York
   ```
