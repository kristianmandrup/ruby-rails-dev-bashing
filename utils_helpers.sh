function size { 
	target = $1
	shift 1
	ls -lR $target | awk '{sum += $5} END{print sum}'
}

function ll {
	ls -al
}

function link {
	path=$1
	link_alias=$2
	shift 2
	ln -s $path $link_alias
}

function install_homebrew {
	sudo chown -R `whoami` /usr/local
	
	cd /usr/local
	git init
	git remote add origin git://github.com/mxcl/homebrew.git
	git pull origin master
}

