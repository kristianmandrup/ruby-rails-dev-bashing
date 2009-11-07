# GEMS

function gem_help {
	echo "Gem shortcut commands:"
	echo "gem_install [name]     : install gem, fx gin hobo-0.8.8 from local .gem file"	
	echo "gem_uninstall [name]   : uninstall gem"
	echo "jewel_build [name]     : build a new gem project using jeweler"
	echo "jewel_proj_repo [name] : build a new gem project using jeweler and set up repository for it on github"
				
	echo "gem_build_f_spec       : build a new gem from a named gem specification file"		
	echo "gem_push               : push gem to gemcutter"			
	echo "gem_build_manf         : create gem manifest"		
	echo "gem_build              : create gem using rake task"
	echo "gem_release            : release gem to gemcutter"				
	echo "gem_version            : display gem version"				
	echo "gem_init_version       : set gem initial version"					
		
	echo "gem_inc_major          : increase major version of gem"
	echo "gem_inc_minor          : increase major version of gem"
	echo "gem_patch              : increase patch version of gem"		

	echo "gem_install            : install gem (jewel)"			
	echo "gem_check_depend       : check all dependencies of gem"				
		
	echo "gem_find [name]           : find named gem"		
	echo "gem_list                  : list all gems installed"		
	echo "github_config [user] [token] : configure your github account locally"	
}

# 1fe3edf89f7282be79f7aea6e00683fc

function github_config {
  	user=$1
	token=$2
  	shift 2
	git config --global github.user $user
	git config --global github.token $token	
}

function gem_check_depend {
	rake check_dependencies
}

function gem_install {
	rake install	
}

function gem_inc_major {
	rake version:bump:major
}   

function gem_inc_minor {           
	rake version:bump:minor
}

function gem_patch {           
	rake version:bump:patch
}


function gem_release {
	rake gemcutter:release
}

function gem_version {
	rake version	
}

function jewel_proj_repo {
  	name=$1
  	shift 1	
	jewel $name --create-repo	
}

function jewel_build {
  	name=$1
  	shift 1	
	jeweler $name --gemcutter
	cd $name
	touch CHANGELOG
	gem_init_version
	echo "A history of changes to the gem..." >> CHANGELOG
}

function gem_init_version {
	rake version:write	
	rake version:bump:minor
}	

function gem_find {
  	name=$1
  	shift 1	
	gem list $name
}

function gem_build_f_spec {
  	name=$1
  	shift 1	
	gem build $name.gemspec
}

function gem_push {
  	name=$1
  	shift 1	
	gem push $name.gem
}


function gem_list {
	gem list 
}


function gem_install {
  	name=$1
  	shift 1	
	gem install $name.gem --local	
}


function gem_uninstall {
  	name=$1
  	shift 1	
	sudo gem uninstall $name
}

function gem_build_manf {
	rake manifest	
}

function gem_build {
	rake gem
}
