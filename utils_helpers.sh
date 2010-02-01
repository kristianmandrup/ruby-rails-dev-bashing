function size { 
	target = $1
	shift 1
	ls -lR $target | awk '{sum += $5} END{print sum}'
}

function ll {
	ls -al
}

function remove {
	if [ -f $1 ]
	then
		rm -rf $1
	fi
}

function link {
	path=$1
	link_alias=$2
	shift 2
	ln -s $path $link_alias
}

