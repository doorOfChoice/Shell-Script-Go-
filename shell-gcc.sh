
name=${name:=$1};

bname=$(basename $name .c)

address=$(pwd);

if [ "$name" == "" ]; then
	return -1
fi

gcc $address/$name -o $address/$bname.out

if [ $? ]; then
	$address/$bname.out
fi
