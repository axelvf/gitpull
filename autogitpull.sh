#!/bin/bash

# Automating git pull scripting
# Author: Axel Vasquez
# Mail: axelv@squez.com.ar
# Repo: https://github.com/axelvf/gitpull
# Date: 2017-02-02
# Version: 0.4

# Configurable Options
Mail_From="from@domain.com"
Mail_To="to@domain.com"
Mail_Cc="cc@domain.com"
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
# Verify differences between the last and new commit
    sm=$(cat $Log_Pull)
    git -C "$Local_Dir" pull origin $Branch > $Log_Pull
    smnew=$(cat $Log_Pull)
    if [ "$sm" == "$smnew" ] || [ "$smnew" == "Already up-to-date." ]
        then echo "Same commit: Nothing to do"
        else cat $Log_Pull $Log_FetchHead | mailx -r "$Mail_From" -s "$Mail_Subject - $(date)" -t $Mail_To ", $Mail_Cc"
    fi
fi
