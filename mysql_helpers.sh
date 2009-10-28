alias start_mysql="$MYSQLCOM start"
alias stop_mysql="$MYSQLCOM stop"
alias restart_mysql="$MYSQLCOM restart"

# MYSQL

function mysql_help {
	echo "start_mysql       : start MySQL server"	
	echo "stop_mysql        : stop MySQL server"	
	echo "restart_mysql     : restart MySQL server"	
	echo "msql          	: open mysql console"		
	echo "msql_root 	    : open mysql console as user=ROOT"
	echo "msql_admin        : get list of mysql admin commands"
	echo "create_db [name]  : create named mysql DB"				
	echo "drop_db [name]    : drop named mysql DB"	
	echo "mysql_kill    : shutdown mysql server!"					
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
