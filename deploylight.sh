#!/bin/bash

COFF='\033[0m'
CBLACK='\033[0;30m'
CRED='\033[0;31m'
CGREEN='\033[0;32m'
CYELLOW='\033[0;33m'
CBLUE='\033[0;34m'
CPURPLE='\033[0;35m'
CCYAN='\033[0;36m'
CWHITE='\033[0;37m'
CGRAY='\033[1;30m'
SED_PATTERN="s/^/$(tput setaf 0)$(tput bold)Docker     : $(tput sgr0) /"
function printf() { builtin printf "${CGRAY}deploy: ${COFF} $1"; }

########################
#### CORE
########################

function firewallsetup()
{
    apt-get install ufw -y
    ufw allow 22/tcp
    ufw allow 2376/tcp
    ufw allow 2377/tcp
    ufw allow 7946/tcp
    ufw allow 7946/udp
    ufw allow 4789/udp
    ufw reload
    ufw enable
    systemctl restart docker
}
function deploy()
{
    #printf "${CGREEN}COnfigure Firewall${COFF}\n"
    firewallsetup
}

deploy
