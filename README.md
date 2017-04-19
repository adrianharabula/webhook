# Docker [almir/webhook](https://hub.docker.com/r/almir/webhook/) image with git installed

## How to use git webhook to make a pull on a remote server.

Create a ssh key with `ssh-keygen -f id_rsa`. Copy id_rsa to webhook/.ssh.  

Upload id_rsa.pub to github as a git deploy key.  

Update private key permissions:  
`chmod 400 webhook/.ssh/id_rsa`

Update hook script permissions:  
`chmod +x webhook/scripts/pull.sh`

Run the image either with docker run:  
```
docker run -d -p 9000:9000 \
-v /path/to/webhook/hooks.json:/etc/webhook/hooks.json \
-v /path/to/webhook/pull.sh:/var/scripts/pull.sh \
-v /path/to/webhook/.ssh:/root/.ssh \
-v /path/to/gitrepo:/root/gitrepo
--name=webhook adrianharabula/webhook
-verbose -hooks=/etc/webhook/hooks.json -hotreload
```

Or either with docker-compose.yml:
```
version: '3'

services:
   webhook:
     image: adrianharabula/webhook
     restart: always
     volumes:
       - "/path/to/webhook/hooks.json:/etc/webhook/hooks.json"
       - "/path/to/webhook/scripts:/var/scripts"
       - "/path/to/webhook/.ssh:/root/.ssh"
       - "/path/to/gitrepo:/root/gitrepo"
     command: "-verbose -hooks=/etc/webhook/hooks.json -hotreload"
     ports:
      - "9000:9000"

volumes:

```

Then go to [localhost:9000/hooks/pull](http://localhost:9000/hooks/pull). This will execute `git pull origin master` in the gitrepo folder as root user.
