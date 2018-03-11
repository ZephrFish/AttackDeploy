# AttackDeploy
## Work In Progress
Scripts for deploying new pentesting VPS, makes all folders, adds repos, tooling, users, wordlists & updates system ready to run whatever you want.

#### Note
This requuires that you run the scripting as root, also if you want to install docker this also requires root. Enjoy! 

## Plans

- Include Fully Automated SSL Setup
- Add OS Hardening
- Setup all tools that have been git cloned

## Usage
Assuming you have git already installed the following line will install things:
```
git clone https://github.com/ZephrFish/AttackDeploy.git && cd AttackDeploy && chmod +x AttackDeploy.sh && ./AttackDeploy.sh
```

If however you do not have git, you can also either copy paste it OR use wget:
```
wget https://raw.githubusercontent.com/ZephrFish/AttackDeploy/master/AttackDeploy.sh -O AttackDeploy.sh && chmod +x AttackDeploy.sh && ./AttackDeploy.sh
```

### Currently Includes

- Recon 
  - DNS
  - Enumeration
  - Mobile
  - Fingerprinting/Profiling
  
  - A bunch of wordlists
  - some other things
  
  
  If you've got tool suggestions, make a pull request
  ----

# AttackDeploy Docker Deployment Kit
Includes Basic tooling for an attack server deployment
Inspiration taken from https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/

You'll want to install docker first:

```
wget https://raw.githubusercontent.com/ZephrFish/DockerAttack/master/InstallDocker.sh && chmod +x InstallDocker.sh && ./InstallDocker.sh
```

# How to Build

```
docker build -t dockerattack/attackdeploy $(pwd)/
```

# How to Run

```
docker run -ti -p 80:80 -p 443:443 -p 8080:8080 -v /tmp/AttackDeploy:/home/AttackDeploy dockerattack/attackdeploy
```

