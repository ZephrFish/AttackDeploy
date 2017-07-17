#!/bin/bash
# AttackDeployAttackTools Only - 0.1
# ZephrFish
# Script for deploying new VPS & downloading all required tools
# This version takes away the SSL setup & OS hardening 
# Note: This is a work in progress :-)

# Root Check
if [ `whoami` != root ]; then
    echo "This script must be run as root"
    exit 1
fi

# Install Basic Repos
rm -rf /etc/apt/sources.list
touch /etc/apt/sources.list
echo "# Debian 9" >> /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list

# Install Kali Repos
apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
echo "# Kali linux repos" >> /etc/apt/sources.list
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

# Update & Upgrade Repo
apt update
apt-get upgrade -y
apt-get dist-upgrade -y

# Install Basics
apt install sudo git wget curl git zip ccze byobu zsh golang  ufw python-pip -y

# Install Basic Attack Tools
apt-get install -y nikto dotdotpwn jsql nmap sqlmap sqlninja thc-ipv6 hydra metasploit-framework dirb

# Make Tools & Wordlists Directory
mkdir /usr/share/wordlists
mkdir /usr/share/tools
mkdir /usr/share/tools/scripts/

# Pull Wordlists
cd /usr/share/wordlists
git clone https://github.com/danielmiessler/SecLists
git clone https://github.com/danielmiessler/RobotsDisallowed
cd SecLists
tar xvzf rockyou.tar.gz

# DNS Tooling
cd /usr/share/tools
mkdir DNS
cd DNS
git clone https://github.com/lorenzog/dns-parallel-prober
git clone https://github.com/aboul3la/Sublist3r
git clone https://github.com/michenriksen/aquatone
git clone https://github.com/guelfoweb/knock
git clone https://github.com/anshumanbh/brutesubs
git clone https://github.com/jhaddix/domain
apt -f install fierce

# CMS Tooling
cd /usr/share/tools
mkdir CMS && cd CMS
git clone https://github.com/droope/droopescan
apt install -y wpscan
git clone https://github.com/Dionach/CMSmap

# Directory Busting
cd /usr/share/tools
apt install dirb -y
git clone https://github.com/OJ/gobuster
git clone https://github.com/henshin/filebuster

# Git Recon
mkdir /usr/share/tools/git
cd /usr/share/tools/git
git clone https://github.com/libcrack/gitrecon
git clone https://github.com/dxa4481/truffleHog
git clone https://github.com/michenriksen/gitrob

# OSINT Tooling 
mkdir /usr/share/tools/OSINT
cd /usr/share/tools/OSINT
apt install -y recon-ng
git clone https://github.com/smicallef/spiderfoot
git clone https://github.com/ZephrFish/GoogD0rker
git clone https://github.com/GerbenJavado/LinkFinder 

# HTTP Analysis
cd /usr/share/tools
git clone https://github.com/ChrisTruncer/EyeWitness 
git clone https://github.com/robertdavidgraham/masscan

# BBF Tooling
mkdir /usr/share/tools/BBF
cd /usr/share/tools/BBF
for y in $(wget https://bugbountyforum.com/tools/ &&  grep "/tools/" index.html | cut -d "=" -f 2 | cut -d "/" -f 2,3 | grep -v ">"); do wget https://bugbountyforum.com/$y; done && for x in $(ls); do grep "href=" $x | cut -d "=" -f 2 | grep github.com | cut -d "/" -f 3,4,5 | cut -d " " -f 1 |sed -e 's/^"//' -e 's/"$//' | grep -v "gist" >> Repos.txt; done && for a in $(cat Repos.txt);do git clone https://$a; done && find . -maxdepth 1 -type f -delete

echo "That's all folks! You're good to go hack the planet!"
