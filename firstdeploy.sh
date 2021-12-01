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

function configure()
{
    printf "${CGREEN}Creating data volumes${COFF}\n"
    
    docker volume create swarmpitdb-data 2>&1 | sed "${SED_PATTERN}"
    docker volume create swarmpitinflux-data 2>&1 | sed "${SED_PATTERN}"

    printf "${CGREEN}Creating networks${COFF}\n"

    docker network create -d overlay --attachable agents 2>&1 | sed "${SED_PATTERN}"
}

function deploy()
{

    configure
    printf "${CGREEN}Deploying stack${COFF}\n"
    if [ ! -f config.env ]; then
        printf "${CRED}No stack-config.env file found${COFF}\n"
        printf "${CRED}Copy of the configuration file sample to configuration file${COFF}\n"
        cp config.env.sample config.env
    fi
    source config.env && docker stack deploy --prune --with-registry-auth --resolve-image=always --compose-file docker-compose.yaml swarmpit 2>&1 | sed "${SED_PATTERN}"
}

deploy
