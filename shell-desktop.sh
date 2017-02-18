#!/bin/bash
#Program:
#	This program can help you to create link desktop shortcuts 
#History:
#	2017/2/18	First release

echo '*choose type:'
echo '1.Application'
echo '2.Link'
read -p '(necessary)the link type '		tp
read -p '(necessary)exec or link address: '	addr
read -p '(necessary)the name of shortcuts '	name
read -p 'the icon address '			icon
read -p 'the comment '				comm
read -p "the destination(default: $HOME) "	aim

aim=${aim:=$HOME}

deskName="$name.desktop"
deskAddr="$aim/$deskName"

if [ -f "$deskAddr" ]; then
	echo "" > $deskAddr
else
	touch $deskAddr
fi

#write the head of desktop
echo "[Desktop Entry]" >> $deskAddr 

#write the type
case $tp in
	'1')
	echo "Type=Application" >> $deskAddr;;
	'2')
	echo "Type=Link"	>> $deskAddr;;
	*)
	echo "type is wrong"
	exit 1
esac

#write the exec or link address
if [ "$addr" != "" ]; then
	echo "Exec=$addr" >> $deskAddr
else
	exit 2
fi	

#write the name 
if [ "$name" != "" ]; then
	echo "Name=$name" >> $deskAddr
else
	exit 3
fi

#write the icon
icon=${icon//\'/}
echo "Icon=$icon" >> $deskAddr

#write the comment
echo "Comment=$comm" >> $deskAddr
echo "Terminal=false" >> $deskAddr

chmod +x $deskAddr || echo "create fail!" && echo "create success" 

exit 0
