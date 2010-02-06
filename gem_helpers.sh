# GEMS

function gem_help {
    context=$1
    shift 1	
	if [[ $context == '' ]]		 		
	then 
		echo "Git shortcut commands:"
		echo ""		
		echo "Git help context specifiers   : install, jewel, gemcutter, version, build, misc"
		echo "- usage: git_help [context]"		
		echo ""
		echo "============================================================================"		
		echo "install"
		echo "============================================================================"
		echo "gem_install [name]     : install gem from local .gem file"	
		echo "sgem_install [name]    : sudo install gem"	
		echo "gem_remove [name]      : remove gem"
		echo "sgem_remove [name]     : sudo remove gem"

		echo "============================================================================"		
		echo "jewel"
		echo "============================================================================"
		echo "jewel_build [name]     : build jewel (gem) project"
		echo "jewel_proj_repo [name] : build jewel (gem) project and repository on github"
		echo "jewel_install          : install jewel (gem)"			

		echo "============================================================================"		
		echo "gemcutter"
		echo "============================================================================"		
		echo "gemcutter_push         : push gem to gemcutter"			
		echo "gemcutter_release      : release gem to gemcutter"				

		echo "============================================================================"		
		echo "version"
		echo "============================================================================"		
		echo "gem_version            : display gem version"				
		echo "gem_init_version       : set gem initial version"					

		echo "gem_inc_major          : increase major version of gem"
		echo "gem_inc_minor          : increase major version of gem"
		echo "gem_patch              : increase patch version of gem"		

		echo "============================================================================"		
		echo "build"
		echo "============================================================================"		
		echo "gem_build              : create gem using rake task"
		echo "gem_build_f_spec       : build a new gem from a named gem specification file"		
		echo "gem_build_manf         : create gem manifest"		
		
		echo "============================================================================"		
		echo "misc"
		echo "============================================================================"				
		echo "gem_check_depend       : check all dependencies of gem"				
		echo "gem_find [name]        : find named gem"		
		echo "gem_list               : list all gems installed"		
	fi

	if [[ $context == 'context' ]]		 		
	then 
		echo "Git help context specifiers   : install, jewel, gemcutter, version, build, misc"
	fi
	
	if [[ $context == 'install' ]]	
	then
		echo "============================================================================"		
		echo "install"
		echo "============================================================================"
		echo "gem_install [name]     : install gem from local .gem file"	
		echo "sgem_install [name]    : sudo install gem"	
		echo "gem_remove [name]      : remove gem"
		echo "sgem_remove [name]     : sudo remove gem"
	fi

	if [[ $context == 'jewel' ]]	
	then
		echo "============================================================================"		
		echo "jewel"
		echo "============================================================================"
		echo "jewel_build [name]     : build jewel project"
		echo "jewel_proj_repo [name] : build jewel project and repository on github"
		echo "jewel_install          : install gem (jewel)"					
	fi
	
	if [[ $context == 'gemcutter' ]]	
	then	
		echo "============================================================================"		
		echo "gemcutter"
		echo "============================================================================"				
		echo "gemcutter_push         : push gem to gemcutter"			
		echo "gemcutter_release      : release gem to gemcutter"				
	fi

	if [[ $context == 'version' ]]	
	then
		echo "============================================================================"		
		echo "version"
		echo "============================================================================"	
		echo "gem_version            : display gem version"				
		echo "gem_init_version       : set gem initial version"					

		echo "gem_inc_major          : increase major version of gem"
		echo "gem_inc_minor          : increase major version of gem"
		echo "gem_patch              : increase patch version of gem"				
	fi

	if [[ $context == 'build' ]]
	then	
		echo "============================================================================"		
		echo "build"
		echo "============================================================================"		
		echo "gem_build              : create gem using rake task"
		echo "gem_build_f_spec       : build a new gem from a named gem specification file"		
	fi

	if [[ $context == 'misc' ]]	
	then	
		echo "============================================================================"		
		echo "misc"
		echo "============================================================================"				
		echo "gem_build_manf               : create gem manifest"		
		echo "gem_check_depend             : check all dependencies of gem"				
		echo "gem_find [name]              : find named gem"		
		echo "gem_list                     : list all gems installed"		
		echo "github_config [user] [token] : configure your github account locally"	
	fi

}

#=======================
# Install
#=======================

function gem_install_local {
  	name=$1
  	shift 1	
	gem install $name.gem --local	
}

function gem_install {
	gem install $@
}


function gem_remove {
  	name=$1
  	shift 1	
	gem uninstall $name
}

#=======================
# Jewel
#=======================
function jewel_proj_repo {
  	name=$1
  	shift 1	
	jewel_build $name --create-repo	
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

function jewel_install {
	rake install	
}


#=======================
# Gemcutter
#=======================
function gemcutter_release {
	rake gemcutter:release
}

function gemcutter_push {
  	name=$1
  	shift 1	
	gem push $name.gem
}

function jewel_push {
  	name=$1
  	shift 1    	
	gem push pkg/$name.gem
}

#=======================
# Version
#=======================
function gem_init_version {
	rake version:write	
	rake version:bump:minor
}

function gem_version {
	rake version	
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

#=======================
# Build
#=======================

function gem_build {
	rake gem
}

function gem_build_f_spec {
  	name=$1
  	shift 1	
	gem build $name.gemspec
}

function gem_build_manf {
	rake manifest	
}


#=======================
# Misc
#=======================

function gem_check_depend {
	rake check_dependencies
}

function gem_find {
  	name=$1
  	shift 1	
	gem list $name
}

function gem_list {
	gem list 
}


