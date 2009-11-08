# HOBO

function hobo_help {
	context=$1
	shift
	if [[ $context == '' ]]		 		
	then 
		echo "Hobo shortcut commands:"
		echo "Context specifiers:   app, migration, model, model_resource, view, theme"
		echo ""		
		echo "============================================================================"		
		echo "app"
		echo "============================================================================"								
		echo "hb [appname]            : new HOBO app named [appname]"
		echo "hb_edge [appname]       : new HOBO app named [appname] using Hobo edge"			
		echo "hb_edge_nogit [appname] : new HOBO app named [appname] using Hobo edge, with .git removed"			
		echo "hb_init [appname]       : new HOBO app named [appname]. Run initial hobo migration NOW"		

		echo "============================================================================"		
		echo "install"
		echo "============================================================================"						
		echo "hb_edge_install         : install Hobo edge from github in Hobo project"			
		echo "hb_edge_install_nogit   : install Hobo edge from github in Hobo project, .git removed"			
		echo "hb_noedge               : Remove Hobo plugin from hobo project"					

		echo "============================================================================"		
		echo "migration"
		echo "============================================================================"						
		echo "hm *                    : generate hobo MIGRATION and run it NOW"
		echo "hm_now [name]           : generate named hobo MIGRATION and run it NOW"	
		echo "hm_init [name]          : run initial hobo MIGRATION"			

		echo "============================================================================"		
		echo "misc"
		echo "============================================================================"						
		echo "hb_nogit                : Remove any .git dir from hobo app and hobo plugin within"

		echo "============================================================================"		
		echo "resource"
		echo "============================================================================"						
		echo "hmr [name]              : generate hobo model RESOURCE"
		echo "hmr_now [name]          : generate new hobo model RESOURCE and run migration NOW"

		echo "============================================================================"		
		echo "model"
		echo "============================================================================"						
		echo "hmdl [name]             : generate hobo MODEL"
		echo "hmdl_now [name]         : generate hobo MODEL and run migration NOW"
		
		echo "============================================================================"		
		echo "dryml"
		echo "============================================================================"						
		echo "hbv [name] [action]     : generate DRYML skeleton for REST action of named model"		
		echo "hbv_all [name]          : generate DRYML skeleton for all REST actions of named model"

		echo "============================================================================"		
		echo "theme"
		echo "============================================================================"						
		echo "hb_theme [name]         : generate hobo THEME plugin, using assets in /public and app/views"
		echo "add_hb_theme [name]     : add hobo THEME from to hobo app (must be in vendor/plugins)"	
		echo ""

		echo "============================================================================"		
		echo "gem"
		echo "============================================================================"						
		echo "hb_edge_gem_install [version] [sudo] : Install edge Hobo cloned from github as a gem"	
		echo "gem_install_local [name] [version]   : Install local Hobo gem from .gem file"		
			
	fi

	if [[ $context == 'app' ]]		 		
	then 
		echo "============================================================================"		
		echo "app"
		echo "============================================================================"								
		echo "hb [appname]            : new HOBO app named [appname]"
		echo "hb_edge [appname]       : new HOBO app named [appname] using Hobo edge"			
		echo "hb_edge_nogit [appname] : new HOBO app named [appname] using Hobo edge, with .git removed"			
		echo "hb_init [appname]       : new HOBO app named [appname]. Run initial hobo migration NOW"		
	fi

	if [[ $context == 'install' ]]		 		
	then 
		echo "============================================================================"		
		echo "install"
		echo "============================================================================"						
		echo "hb_edge_install         : install Hobo edge from github in Hobo project"			
		echo "hb_edge_install_nogit   : install Hobo edge from github in Hobo project, .git removed"			
		echo "hb_noedge               : Remove Hobo plugin from hobo project"					
	fi
	
	if [[ $context == 'migration' ]]		 		
	then 
		echo "============================================================================"		
		echo "migration"
		echo "============================================================================"						
		echo "hm *                    : generate hobo MIGRATION and run it NOW"
		echo "hm_now [name]           : generate named hobo MIGRATION and run it NOW"	
		echo "hm_init [name]          : run initial hobo MIGRATION"			
	fi

	if [[ $context == 'model' ]]		 		
	then 
		echo "============================================================================"		
		echo "model"
		echo "============================================================================"						
		echo "hmdl [name]             : generate hobo MODEL"
		echo "hmdl_now [name]         : generate hobo MODEL and run migration NOW"
	fi

	if [[ $context == 'resource' ]]		 		
	then 
		echo "hmr [name]              : generate hobo model resource"
		echo "hmrn [name]             : generate new hobo model resource and run migration NOW"
	fi

	if [[ $context == 'dryml' ]]		 		
	then 
		echo "============================================================================"		
		echo "dryml"
		echo "============================================================================"						
		echo "hbv [name] [action]           : gen. DRYML skeleton for REST action of named model"		
		echo "hbv_all [name]                : gen. DRYML skeleton for all REST actions"
		echo ""
		echo "EXAMPLE: > hbv recipes index  : generates index.dryml skeleton for recipe model"
	fi
	
	if [[ $context == 'theme' ]]		 		
	then 
		echo "============================================================================"		
		echo "theme"
		echo "============================================================================"						
		echo "hb_theme [name]         : generate hobo THEME plugin, using assets in /public and app/views"
		echo "add_hb_theme [name]     : add hobo THEME from to hobo app (must be in vendor/plugins)"	
		echo ""
	fi

	if [[ $context == 'gem' ]]		 		
	then 
		echo "============================================================================"		
		echo "gem"
		echo "============================================================================"						
		echo "hb_edge_gem_install [version] [sudo] : Install edge Hobo cloned from github as a gem"	
		echo "gem_install_local [name] [version]   : Install local Hobo gem from .gem file"		
	fi

	
}

function hb_nogit {
	rm -rf .git*	
	rm -rf vendor/plugins/hobo/.git*	
}

function hb_noedge {
	rm -rf vendor/plugins/hobo	
}

function hb_edge {
  	appname=$1
  	shift 1
	hb $appname
	instpl_ghub tablatom hobo
	hm_init $appname	
}

function hb_edge_nogit {
  	appname=$1
  	shift 1
	hb $appname
	instpl_ghub tablatom hobo
	rm -rf vendor/plugins/hobo/.git*
	hm_init $appname	
}


function hb_edge_install {
	instpl_ghub tablatom hobo
}

function hb_edge_install_nogit {
	instpl_ghub tablatom hobo
	hb_nogit
}


function hb {
  name=$1
  shift 1
  echo 'Generating HOBO RAILS app...'
  hobo $name $@
  cd $name
}

function hb_init {
  name=$1
  shift 1  
  hb $name $@
  hm_init $name
}

function hm {
  name=$1
  shift 1  
  echo 'Generating Hobo MIGRATION...'		
  sg hobo_migration --default-name $name $@
}

function hm_now {
  name=$1
  shift 1  
  echo 'Generating Hobo MIGRATION...'		
  hm $name --migrate $@ 
}


function hm_init {
  name=$1
  shift 1  
  hm_now "initialize_$1"
}

function hmr {
  name=$1
  shift 1
  echo 'Generating Hobo MODEL resource...'	
  sg hobo_model_resource $name $@
}

function hmr_now {
  name=$1
  shift 1
  hmr $name $@
  hm_now "create_$name"
}


function hmdl {
  name=$1
  shift 1
  echo 'Generating Hobo MODEL ...'		
  sg hobo_model $name @$ 
}


function hmdl_now {
  name=$1
  shift 1
  echo 'Generating Hobo MODEL ...'		
  sg hobo_model --migrate $name @$
}


function hb_edge_gem_install {
    $version=$1
    $sudo=$2
    shift 2
	echo "Installing hobo gem, version = $version ..."
    echo "Uninstalling old hobo gem"
	$sudo gem uninstall hobo
    echo "Retrieving edge hobo from github"
    gchub tablatom hobo
    cd hobo
    echo "Creating gem manifests for: hobo, hobosupport and hobofields"
    cd hobo
    rake manifest
    cd ..
    cd hobosupport
    rake manifest
    cd ..
    cd hobofields
    rake manifest
    echo "Creating gems for: hobo, hobosupport and hobofields"
    rake gem
    cd ..
    cd hobosupport
    rake gem
    cd ..
    cd hobo
    rake gem   
    cd ..
    echo "copy packaged gems to root"
    cp hobo/pkg/*.gem .
    cp hobosupport/pkg/*.gem .
    cp hobofields/pkg/*.gem .
    echo "install hobo gems to local gem repo"
	$sudo gem install hobo-$version.gem --local
}

function gem_install_local {
	$name
    $version=$1	
	shift 2
	sudo gem install $name-$version.gem --local	$@
}


function hbv {
	name=$1
	action=$2
	shift 2
	touch app/views/$name/$action.dryml
	echo "<$action-page>" >> app/views/$name/$action.dryml			
	echo "  <!-- your customized view code here -->" >> app/views/$name/$action.dryml
	echo "</$action-page>" >> app/views/$name/$action.dryml	
}

function hbv_all {
	name=$1
	hbv $name index
	hbv $name show
	hbv $name new	
	hbv $name edit		
}


# Hobo THEMES
function hb_theme {
	name=$1 
	echo "Generating hobo theme plugin '$name' in vendor/plugins"	
	echo "Add plugin in hobo app using: add_hobo_theme $name"	
	mkdir vendor/plugins/$name 
	cd vendor/plugins/$name
	mkdir taglibs 
	mkdir -p public/$name 
	mkdir public/$name/stylesheets 
	mkdir public/$name/images 
	cd ../../..
	cp app/views/taglibs/application.dryml vendor/plugins/$name/taglibs/$name.dryml 
	cp public/stylesheets/application.css vendor/plugins/$name/public/$name/stylesheets/$name.css 
	rm public/images/rails.png
	cp -R public/images/* vendor/plugins/$name/public/$name/images 
}

function add_hb_theme {
	name=$1
	echo "Copying assets for theme plugin '$name' to public"
	cp -R vendor/plugins/$name/public/* public	
	echo "Adding <include src='$name' plugin='$name'/> at the end of app/views/taglibs/application.dryml"
	echo "<include src='$name' plugin='$name'/>" >> app/views/taglibs/application.dryml
}
