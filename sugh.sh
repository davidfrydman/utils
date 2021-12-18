#!/bin/bash

if [ -z "$1" ]; then
    echo "waiting for the following argument: username" 
    exit 1
else
    name=$1
fi

mkdir -p "$name"
cd "$name"

cntx="users"
counter="1"

echo name: $name
echo cntx: $cntx

while true
do
	echo page: $counter
	page=$(curl "https://api.github.com/$cntx/$name/repos?page=$counter&per_page=100")
	if [ ! $(echo "$page" |grep -e 'git_url') ]; then
		break;
	fi
	echo -e "$page" | grep -e 'git_url*' | cut -d \" -f 4 | xargs -L1 git clone
	counter=$(expr $counter + 1)
done

exit 0
