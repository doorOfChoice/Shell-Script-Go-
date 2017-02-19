#!/bin/bash
#Programming:
#	backup databases interval time
#History:
#	2017/2/19	First release

PATH=$PATH:/usr/bin
export PATH

read -p 'Print the destination folder: ' dir
read -p 'print the mysql account: '	 user
read -p 'print the mysql password: '	 pawd

#replace the special symbol
dir=${dir//\~/$HOME}

if [ ! -d "$dir" ]; then
	if 
		mkdir "$dir";
	then
		echo "create successful"
	else
		echo "create fail, exit"
		exit 1
	fi
fi

while true
do
	sum=""
	for basename in $@
	do
		sum="$sum$basename "				
	done

	if 
		mysqldump -u $user -p$pawd --databases $sum >> "$dir/$(date +%Y%m%d%k).sql"
	then
		echo "Dumped, $(date)"
	else
		echo "Can't connect to mysql"
		exit 2
	fi
	sleep 12h
done

exit 0
