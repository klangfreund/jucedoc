#!/bin/bash
#
# author: Samuel Gaehwiler (klangfreund.com)
#
# This gets called daily via a cron job:
# # ------------------- juce api documentation -------------------
# 
# #min    hour    mday    month   wday    command
# 00      20      *       *       *       cd /home/juce/data/docs/development/jucedoc/; /home/juce/data/docs/development/jucedoc/update.sh >/dev/null

currentDirectory=`pwd`
juceDirectory=~/data/res/development/juce

# Get the latest JUCE
git --git-dir $juceDirectory/.git pull

# Update the documentation
cd $juceDirectory/doxygen/
doxygen

# Copy it over
cd $currentDirectory
rm -r doc
cp -r $juceDirectory/doxygen/doc .
# rsync --progress -avz --delete $juceDirectory/doxygen/doc/* doc/

# Commit and upload
git add --all .
git commit -m "Automatic update."

# Important: Don't set a password for your ssh key, or 'git push' wont work when run from cron.
git push
