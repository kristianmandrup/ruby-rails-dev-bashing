# HEROKU

function heroku_help {	
	context=$1
	shift
	if [[ $context == '' ]]		 		
	then 
		echo "Heroku shortcut commands:"
		echo "Context specifiers:   app, db"
		echo ""		
		echo "hcr [name]       : create heroku application (requires git repository)"	
		echo "hpush            : push heroku app from git repo to heroku server"
		echo "hdb_push         : push local database to heroku server"
		echo "hdb_pull         : pull heroku database to local"
		echo "hdb_mig          : run database migrations on heroku server"
		echo "hdb_reset        : reset database on heroku server"	
	fi

	if [[ $context == 'app' ]]		 		
	then 
		echo "hcr [name]       : create heroku application (requires git repository)"	
		echo "hpush            : push heroku app from git repo to heroku server"
	fi

	context=$1
	shift
	if [[ $context == 'db' ]]		 		
	then 
		echo "hdb_push         : push local database to heroku server"
		echo "hdb_pull         : pull heroku database to local"
		echo "hdb_mig          : run database migrations on heroku server"
		echo "hdb_reset        : reset database on heroku server"	
	fi
}

function hcr {
     name=$1
     shift 1
     echo "Heroku CREATE app '$name' ..."
     heroku create $name $@
}

function hpush {
     echo 'Heroku PUSH app'
     heroku push origin master
}

function hdb_push {
      echo 'Heroku PUSH locl database to server'
     heroku db:push
}

function hdb_pull {
      echo 'Heroku PULL database from server to local database'
     heroku db:pull
}


function hdb_mig {
      echo 'Heroku RUN database migration...'
     heroku rake db:migrate
}

function hdb_reset {
      echo 'Heroku RESET database ...'
     heroku rake db:reset
}
