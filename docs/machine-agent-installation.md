#Machine Agent Installation:

1. create a directory for your agents in controller host. ideally: ```/opt/appdynamics/agents```
2. copy the agent's compressed zip file into that folder
3. exctract the zip file ``` unzip machine-agent-xxx.zip /opt/appdynamics/agents/machine-agent```
4. edit conf/controller-info.xml and add host ip and ports
5. go to controller settings > license> access key and put it inside the access key brackets in controller-info.xml
6. start the machine agent using running /bin/machine-agent

#DB agent
./bin/mysql --socket=mysql.sock -u root -p
