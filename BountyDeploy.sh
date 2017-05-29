#!/bin/bash
# BountyDeploy - 0.1
# ZephrFish
# Script for deploying new VPS & downloading all required tools

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
echo "# Kali linux repos\ndeb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

# Update & Upgrade Repo
apt update
apt-get upgrade -y
apt-get dist-upgrade -y

# Install Basics
apt install sudo git wget curl git zip ccze byobu zsh -y

# Install Basic Attack Tools
apt-get install -y nikto dotdotpwn jsql nmap sqlmap sqlninja thc-ipv6 hydra metasploit-framework dirb

# Make Tools & Wordlists Directory
mkdir /usr/share/wordlists
mkdir /usr/share/tools
mkdir /usr/share/tools/scripts/

# Pull Wordlists
cd /usr/share/wordlists
git clone https://github.com/danielmiessler/SecLists/
cd SecLists
tar xvzf rockyou.tar.gz
