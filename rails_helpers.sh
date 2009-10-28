# RAILS

function rails_help {
	context=$1
	shift	
	if [[ $context == '' ]]		 		
	then 	
		echo "Rails shortcut commands:"	
		echo "Context specifiers:   app, migration, plugin"
		echo ""	
		echo "rls [app] *                 : create rails app"	
		echo "rapp_rb [template] [app] *  : create rails app using named template from ryanbates github repo"	
		echo "rapp [template] [app] *     : create rails app using named template from local ~/rails-templates/"
		echo "ss *                        : start rails server"
		echo "ssp [port] *                : start rails server on specific port"
		echo "sg *                        : run script/generate"
		echo "rmig [name] *               : create named rails migration"		
		echo "rmign [name] *              : create named rails migration and run it now!"		
		echo "rpl_in [name]               : install rails plugin"	
		echo "instpl_ghub [repo] [name]   : install rails plugin from github repo"
		echo "rperf                       : run performance script on application"
		echo "rabout                      : print info on rails version used in app"
		echo "rcons                       : start rails console"
		echo "rdbcons                     : rails database console"
		echo "rpl *                       : rails plugin"
		echo "rpl_cr [name]               : create (generate) rails plugin"
		echo "rpl_un [name]               : uninstall rails plugin"
		echo "rgit_ignore                 : Create .gitignore file for rails app"
	fi

	if [[ $context == 'migration' ]]		 		
	then 	
		echo "rmig [name] *               : create named rails migration"		
		echo "rmign [name] *              : create named rails migration and run it now!"			
	fi

	if [[ $context == 'plugin' ]]		 		
	then 	
		echo "rpl_in [name]               : install rails plugin"	
		echo "instpl_ghub [repo] [name]   : install rails plugin from github repo"
		echo "rpl *                       : rails plugin"
		echo "rpl_cr [name]               : create (generate) rails plugin"
		echo "rpl_un [name]               : uninstall rails plugin"
	fi

	if [[ $context == 'app' ]]		 		
	then 	
		echo "rls [app] *                 : create rails app"	
		echo "rls_edge [app] *            : create rails app using edge rails (3.0) - see http://www.linux-mag.com/cache/7478/1.html"	
		echo ""
		echo "rapp_rb [template] [app] *  : create rails app using named template from ryanbates github repo"	
		echo "rapp [template] [app] *     : create rails app using named template from local ~/rails-templates/"
	fi
	
}


function rgit_ignore { 
	echo "Create Rails git .ignore"
	rm -rf .gitignore
	echo .DS_Store >> .gitignore
	echo "log/*.log" >> .gitignore
	echo tmp/**/* >> .gitignore	
	echo config/database.yml >> .gitignore
	echo db/*.sqlite3 >> .gitignore
}

function rls {
  name=$1
  shift 1
  echo 'Generating RAILS app...'
  rails $name $@
  cd $name
  rgit_ignore
}

function rls_edge {
  name=$1
  shift 1
  rls $name
  echo 'Freezing rails edge ...'
  rake rails:freeze:edge
}

function rapp {
  template=$1
  appname=$2
  shift 2
  echo "Generating new RAILS app: $appname using local $template from ~/rails-templates/ "   
  echo "Available templates: ..."
  rails $appname -m ~/rails-templates/$template.rb $@
}

function rapp_rb {
  template=$1
  appname=$2
  shift 2
  echo "Generating new RAILS app: $appname using $template from ryanb github repo"
  echo "Available templates: ..."
  rails $appname -m http://github.com/ryanb/rails-templates/raw/master/$template.rb $@
}

function rmig {
  name=$1
  shift 1
  echo "Generating MIGRATION '$name' ..."   
  sg migration $name $@
}

# create rails migration and run now
function rmign {
  name=$1
  shift 1
  rmig $name
  rdbm
}

function ss {
  script/server $@
}

function ssp {
  port = $1
  shift 1	
  ss -p $port $@
}

function sg {
  echo 'Rails GENERATE...'       
  script/generate $@
}

function rperf {
  echo 'PERFORMANCE:'
  script/performance $@
}

function rabout {
  echo 'ABOUT RAILS:'   
  script/about $@
}

function rcons {
  echo 'Opening RAILS console...'   
  script/console $@
}

function rdbcons {
  echo 'Opening DATABASE console...'
  script/dbconsole $@
}

function rpl {
  echo 'RAILS plugin ...'   
  script/plugin $@
}

function rpl_cr {
  echo 'Generating PLUGIN...'   
  sg plugin $@
}

function rpl_in {
  name=$1
  shift 1   
  echo "INSTALL PLUGIN '$name' ..."
  plugin install $name
}

function rpl_un {
  name=$1
  shift 1   
  echo "UNINSTALL PLUGIN '$name' ..."
  plugin uninstall $name
}


function instpl_ghub {
  name=$1
  pl_name=$2
  shift 2   
  echo "INSTALL PLUGIN '$pl_name' from '$name' on github ..."
  cd vendor/plugins
  gchub $name $pl_name
  rm -rf .git*
  cd ../..
}


