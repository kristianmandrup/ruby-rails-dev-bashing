# RAKE

# TODO: create script to make .gems file for heroku with gems taken frrom environment.rb
function rake_help {
	context=$1
	shift
	if [[ $context == '' ]]		 		
	then 	
		echo "Rake shortcut commands:"
		echo "Rake context specifiers:   rollback, redo"
		echo ""	
		echo "============================================================================"		
		echo "migrations"
		echo "============================================================================"								
		echo "rdbm [name] *    : run database migrations"	

		echo "============================================================================"		
		echo "rollback"
		echo "============================================================================"								
		echo "rbk *            : rollback database migrations, fx rbk STEP=3"
		echo "rback [# steps]  : rollback database migrations a number of steps, fx rback 7"

		echo "============================================================================"		
		echo "redo"
		echo "============================================================================"								
		echo "rdo *            : redo database migrations, fx redo STEP=2"
		echo "redo [# steps]   : redo database migrations a number of steps, fx redo 7"
		
		echo "============================================================================"		
		echo "reset"
		echo "============================================================================"								
		echo "reset            : reset database"
		
		echo "============================================================================"		
		echo "gems"
		echo "============================================================================"								
		echo "inst_gems        : install gems configured for rails environment.rb"
		
	fi

	if [[ $context == 'rollback' ]]		 		
	then 	
		echo "rbk *            : rollback database migrations, fx rbk STEP=3"
		echo "rback [# steps]  : rollback database migrations a number of steps, fx rback 7"
	fi

	if [[ $context == 'redo' ]]		 		
	then 	
		echo "rdo *            : redo database migrations, fx redo STEP=2"
		echo "redo [# steps]   : redo database migrations a number of steps, fx redo 7"
	fi
}


function rdbm {
  name=$1
  shift 1
  echo 'Migrating RAILS migrations...'
  rake db:migrate $@
}

function rbk {
  echo 'Rolling back RAILS migrations...'
  rake db:rollback $@
}

function rback {
  steps=$1
  shift 1
  echo "Rolling back $steps RAILS migrations..."
  rake db:rollback STEP=$steps $@
}

function rdo {
  echo 'Redo RAILS migrations...'
  rake db:migrate:redo $@
}

function redo {
  steps=$1
  shift 1
  echo "Redo $steps RAILS migrations..."
  rake db:migrate:redo STEP=$steps $@
}

function reset {
  echo "Resetting database..."
  rake db:reset
}

function rinst_gems {
	rake gems:install
}





