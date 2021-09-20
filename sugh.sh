#!/bin/bash

if [ -z "$1" ]; then
    echo "waiting for the following argument: username" 
    exit 1
else
    name=$1
fi


cntx="users"

echo $name
echo $cntx

curl -u $name "https://api.github.com/$cntx/$name/repos?page=1&per_page=100" | grep -e 'git_url*' | cut -d \" -f 4 | xargs -L1 git clone

exit 0
