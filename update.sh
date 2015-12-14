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
# HOME=/home/juce

git push
