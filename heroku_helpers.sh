# HEROKU

function heroku_help {	
	context=$1
	shift
	if [[ $context == '' ]]		 		
	then 
		echo "Heroku shortcut commands:"
		echo "Context specifiers:   app, deploy, db"
		echo ""		
		echo "============================================================================"		
		echo "app"
		echo "============================================================================"										
		echo "hcr [name]       : create heroku application (requires git repository)"	
		echo ""		
		echo "============================================================================"		
		echo "deploy"
		echo "============================================================================"										
		echo "hpush            : push heroku app from git repo to heroku server"
		echo ""
		echo "============================================================================"		
		echo "db"
		echo "============================================================================"						
		echo "hdb_push         : push local database to heroku server"
		echo "hdb_pull         : pull heroku database to local"
		echo "hdb_mig          : run database migrations on heroku server"
		echo "hdb_reset        : reset database on heroku server"	
	fi

	if [[ $context == 'app' ]]		 		
	then 
		echo "============================================================================"		
		echo "app"
		echo "============================================================================"						
		echo "hcr [name]       : create heroku application (requires git repository)"	
	fi

	if [[ $context == 'deploy' ]]		 		
	then 
		echo "============================================================================"		
		echo "deploy"
		echo "============================================================================"						
		echo "hpush            : push heroku app from git repo to heroku server"
		echo "hpush_m          : push heroku app to heroku server MASTER branch"
	fi


	context=$1
	shift
	if [[ $context == 'db' ]]		 		
	then 
		echo "============================================================================"		
		echo "db"
		echo "============================================================================"						
		echo "hdb_push         : push local database to heroku server"
		echo "hdb_pull         : pull heroku database to local"
		echo "hdb_mig          : run database migrations on heroku server"
		echo "hdb_reset        : reset database on heroku server"	
	fi
}

#=======================
# App
#=======================
# create Heroku application (by setting identifier in .git)
function heroku_create_app {
     name=$1
     shift 1
     echo "Heroku CREATE app '$name' ..."
     heroku create $name $@
}

#=======================
# Deploy
#=======================
function heroku_push_master {
     echo 'Heroku PUSH app to master'
     heroku push origin master
}


function heroku_push {
     echo 'Heroku PUSH app'
     heroku push
}

#=======================
# Database
#=======================
function heroku_push_db {
      echo 'Heroku PUSH locl database to server'
     heroku db:push
}

function heroku_pull_db {
      echo 'Heroku PULL database from server to local database'
     heroku db:pull
}


function heroku_migrate_db {
      echo 'Heroku RUN database migration...'
     heroku rake db:migrate
}

function heroku_reset_db {
      echo 'Heroku RESET database ...'
     heroku rake db:reset
}
