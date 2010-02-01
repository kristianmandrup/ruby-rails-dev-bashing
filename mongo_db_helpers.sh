function mongo_stop {
	pid=`ps -o pid,command -ax | grep mongod | awk '!/awk/ && !/grep/ {print $1}'`;
	if [ "${pid}" != "" ]; then
	    kill -2 ${pid};
	fi
}

function mongo_start {
	mongod --dbpath ~/data/db/
}

function mongo_db_install {
	mkdir -p $HOME/Library/LaunchAgents/
	curl -s http://gist.github.com/265272.txt | bash			
}	
