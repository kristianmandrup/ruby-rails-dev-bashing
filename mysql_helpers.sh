alias start_mysql="$MYSQLCOM start"
alias stop_mysql="$MYSQLCOM stop"
alias restart_mysql="$MYSQLCOM restart"

function setup_mysql_sock {
	sudo ln -s /opt/local/var/run/mysql5/mysqld.sock /tmp/mysql.sock
}

function mysql_autostart {
	sudo launchctl load -w /Library/LaunchDaemons/org.macports.mysql5.plist
}

# MYSQL

function mysql_help {
	echo "============================================================================"		
	echo "execution"
	echo "============================================================================"						
	echo "start_mysql       : start MySQL server"	
	echo "stop_mysql        : stop MySQL server"	
	echo "restart_mysql     : restart MySQL server"	
	echo "mysql_kill    : shutdown mysql server!"						

	echo "============================================================================"		
	echo "console"
	echo "============================================================================"						
	
	echo "msql          	: open mysql console"		
	echo "msql_root 	    : open mysql console as user=ROOT"

	echo "============================================================================"		
	echo "misc"
	echo "============================================================================"						
	echo "msql_admin        : get list of mysql admin commands"

	echo "============================================================================"		
	echo "db"
	echo "============================================================================"							
	echo "create_db [name]  : create named mysql DB"				
	echo "drop_db [name]    : drop named mysql DB"	

}

function msql {
	mysql -p
}

function msql_root {
	mysql -u root -p
}

function msql_admin {
	mysqladmin
}


function msql_kill {
	mysqladmin shutdown
}

function create_db {
	name=$1
	shift		
	mysqladmin create database $name	
}

function drop_db {
	name=$1
	shift		
	mysqladmin drop database $name	
}
