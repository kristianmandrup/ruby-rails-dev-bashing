# RAILS

export RYANB_TEMPLATES_GITHUB=http://github.com/ryanb/rails-templates/raw/master

function rails_help {
	context=$1
	shift	
	if [[ $context == '' ]]		 		
	then 	
		echo "Rails shortcut commands:"	
		echo "Context specifiers:   app, migration, domain, plugin, cleanup, console, info, todo"
		echo ""	

		echo "============================================================================"		
		echo "app"
		echo "============================================================================"						
		
		echo "rls [app] *                 : create rails app"	
		echo "rapp_rb [template] [app] *  : create rails app using named template from ryanbates github repo"	
		echo "rapp [template] [app] *     : create rails app using named template from local ~/rails-templates/"
		
		echo "============================================================================"		
		echo "server"
		echo "============================================================================"						
		
		echo "ss *                        : start rails server"
		echo "ssp [port] *                : start rails server on specific port"
		echo "sg *                        : run script/generate"
		
		echo "============================================================================"		
		echo "migration"
		echo "============================================================================"						
		
		echo "rg_mig [name] *             : create named rails migration"		
		echo "rg_mig_now [name] *         : create named rails migration and run it now!"

		echo "============================================================================"		
		echo "domain"
		echo "============================================================================"						

		echo "rg_modl [name] field:type * : create named rails model with fields"		
		echo "rg_contr [name] m1 m2 *     : create named rails controller with method placeholders"
		echo "rg_scaf [name] m1 m2 *      : create a rails scaffold to produce migration, model, controller, route and views"

		echo "============================================================================"		
		echo "cleanup"
		echo "============================================================================"						
		echo "rcache_clear                : clear rails cache"		
		echo "rlog_clear                  : clear rails log directory"
				
		echo "============================================================================"		
		echo "install"
		echo "============================================================================"										
		echo "rpl_inst [name]             : install rails plugin"	
		echo "rpl_inst_ghub [name] [repo] : install rails plugin from github repo"

		echo "============================================================================"		
		echo "misc"
		echo "============================================================================"						
		
		echo "rperf                       : run performance script on application"
		echo "rgit_ignore                 : Create .gitignore file for rails app"		

		echo "============================================================================"		
		echo "info"
		echo "============================================================================"						
		
		echo "rabout                      : print info on rails version used in app"
		echo "routes                      : display routes"
		
		echo "============================================================================"		
		echo "console"
		echo "============================================================================"						
		
		echo "rcons                       : start rails console"
		echo "rdbcons                     : rails database console"

		echo "============================================================================"		
		echo "plugin"
		echo "============================================================================"						

		echo "rpl *                       : rails plugin"
		echo "rpl_cr [name]               : create (generate) rails plugin"
		echo "rpl_un [name]               : uninstall rails plugin"

		echo "============================================================================"		
		echo "todo"
		echo "============================================================================"						

		echo "r_todo_all                   : search for all kinds of todo comments"		
		echo "r_fixme                      : search for all fixme comments"
		echo "r_optimize                   : search for all fixme comments"		
		echo "r_todo                       : search for all fixme comments"				



	fi

	if [[ $context == 'console' ]]		 		
	then 	
		echo "rcons                       : start rails console"
		echo "rdbcons                     : rails database console"
	fi

	if [[ $context == 'todo' ]]	
	then	 		
		echo "r_todo_all                   : search for all kinds of todo comments"		
		echo "r_fixme                      : search for all fixme comments"
		echo "r_optimize                   : search for all fixme comments"		
		echo "r_todo                       : search for all fixme comments"				
	fi

	if [[ $context == 'info' ]]		 		
	then 	
		echo "rabout                      : print info on rails version used in app"
		echo "routes                      : display routes"
	fi

	if [[ $context == 'migration' ]]		 		
	then 	
		echo "rg_mig [name] *             : create named rails migration"		
		echo "rg_mig_noe [name] *         : create named rails migration and run it now!"
	fi

	if [[ $context == 'domain' ]]
	then		 		
		echo "rg_mig [name] *             : create named rails migration"		
		echo "rg_mig_noe [name] *         : create named rails migration and run it now!"

		echo "rg_modl [name] field:type * : create named rails model with fields"		
		echo "rg_contr [name] m1 m2 *     : create named rails controller with method placeholders"
		echo "rg_scaf [name] m1 m2 *      : create a rails scaffold to produce migration, model, controller, route and views"
	fi

	if [[ $context == 'cleanup' ]]		 		
	then 	
		echo "rcache_clear                : clear rails cache"		
		echo "rlog_clear                  : clear rails log directory"
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

#=======================
# App
#=======================

function rails_app {
  name=$1
  shift 1
  echo 'Generating RAILS app...'
  rails $name $@
  cd $name
  rgit_ignore
}

function rails_edge_app {
  name=$1
  shift 1
  rls $name
  echo 'Freezing rails edge ...'
  rake rails:freeze:edge
}

function rails_app_template {
  template=$1
  appname=$2
  shift 2
  echo "Generating new RAILS app: $appname using local $template from ~/rails-templates/ "   
  echo "Available templates: ..."
  rails $appname -m ~/rails-templates/$template.rb $@
}

function rails_app_ryanb {
  template=$1
  appname=$2
  shift 2
  echo "Generating new RAILS app: $appname using $template from ryanb github repo"
  echo "Available templates: ..."
  rails $appname -m $RYANB_TEMPLATES_GITHUB/$template.rb $@
}

#=======================
# Migration
#=======================

function rails_migration {
  name=$1
  shift 1
  echo "Generating MIGRATION '$name' ..."   
  sg migration $name $@
}

# create rails migration and run now
function rails_migration_now {
  name=$1
  shift 1
  rails_migration $name
  rdbm
}

#=======================
# Controller
#=======================

function rails_controller {
  name=$1
  shift 1
  sg controller $name $@
}

#=======================
# Model
#=======================

function rails_model {
  name=$1
  shift 1
  sg model $name $@
}

#=======================
# Resource
#=======================

function rails_resource {
  name=$1
  shift 1
  sg resource $name $@
}

#=======================
# Scaffold
#=======================

function rails_scaffold {
  name=$1
  shift 1
  sg scaffold $name $@
}

#=======================
# Server
#=======================

function ss {
  script/server $@
}

function ssp {
  port = $1
  shift 1	
  ss -port=$port $@
}


#=======================
# Todo
#=======================
function r_todo_all { 
	rake notes
}

function r_todo { 
	rake notes:todo
}

function r_fixme { 
	rake notes:fixme
}

function r_optimize { 
	rake notes:optimize
}

#=======================
# Misc
#=======================

function cache_clear {
	rake tmp:cache:clear
}

function log_clear {
	rake log:clear
}

function routes {
	rake routes
}

function generate {
  echo 'Rails GENERATE...'       
  script/generate $@
}

function rails_performance {
  echo 'PERFORMANCE:'
  script/performance $@
}

function rails_about {
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

#=======================
# Plugin
#=======================

function rplugin {
  echo 'RAILS plugin ...'   
  script/plugin $@
}

function gen_plugin {
  echo 'Generating PLUGIN...'   
  sg plugin $@
}

function install_plugin {
  name=$1
  shift 1   
  echo "INSTALL PLUGIN '$name' ..."
  plugin install $name
}

function uninstall_plugin {
  name=$1
  shift 1   
  echo "UNINSTALL PLUGIN '$name' ..."
  plugin uninstall $name
}

function plugin_from_github {
  repo_name=$2
  plugin_name=$1
  shift 2   
  echo "INSTALL PLUGIN '$plugin_name' from '$repo_name' on github ..."
  cd vendor/plugins
  gchub $repo_name $plugin_name
  rm -rf .git*
  cd ../..
}


