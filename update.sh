#!/bin/bash
#
# author: Samuel Gaehwiler (klangfreund.com)

currentDirectory=`pwd`
juceDirectory=~/data/res/development/juce

# Get the latest JUCE
git --git-dir $juceDirectory/.git pull

# Update the documentation
cd $juceDirectory/doxygen/
doxygen

# Copy it over
cd $currentDirectory
rsync --progress -avz --delete $juceDirectory/doxygen/doc .

# Commit and upload
git add --all .
git commit -m "Automatic update."

# Needed to make 'git push' work from within a cron job
# (Source: http://stackoverflow.com/questions/16578520/git-push-not-working-inside-a-cron-job )
export SSH_AGENT_PID=`ps -a | grep ssh-agent | grep -o -e [0-9][0-9][0-9][0-9]`
export SSH_AUTH_SOCK=`find /tmp/ -path '*keyring-*' -name '*ssh*' -print 2>/dev/null`

git push
