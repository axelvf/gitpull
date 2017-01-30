#!/bin/bash

# Automating git pull scripting
# Author: Axel Vasquez
# Mail: axelv@squez.com.ar
# Repo: https://github.com/axelvf/gitpull
# Date: 2017-01-28
# Version: 0.1

# Configurable Options
Mail_From="from@domain.com"
Mail_To="to@domain.com"
Mail_Subject="Git: New changes detected"

Git_Repo="git@github.com:axelvf/gitpull.git"
Branch="master"
Local_Dir="/var/www/axelvf/"

# Do not change the lines below
Log_Pull="/tmp/cron_git_pull.log"
Log_FetchHead="/tmp/cron_git_fetch.log"

# Check if exists ssh keys
if [ ! -f ~/.ssh/id_rsa ] || [ ! -f ~/.ssh/id_rsa.pub ] ; then
    echo "SSH keys not found!"
    echo "Use ssh-keygen command to create key pair"
    echo "More info: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"
    exit
fi

# Start check using fetch
git -C "$Local_Dir" fetch origin $Branch
git -C "$Local_Dir" log -p HEAD..FETCH_HEAD > $Log_FetchHead

if [[ $(git -C "$Local_Dir" diff origin/$Branch | wc -c) -eq 0 ]]
    then echo "Up-to-date: Nothing to do"
else
    git -C "$Local_Dir" pull origin $Branch > $Log_Pull
    cat $Log_Pull $Log_FetchHead | mailx -r "$Mail_From" -s "$Mail_Subject - $(date)" $Mail_To
fi
