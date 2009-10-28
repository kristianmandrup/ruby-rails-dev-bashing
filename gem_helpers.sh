# GEMS

function gem_help {
	echo "Gem shortcut commands:"
	echo "gin [name]             : install gem, fx gin hobo-0.8.8"	
	echo "sgin [name]            : sudo install gem"	
	echo "gun [name]             : uninstall gem"
	echo "jewel [name]           : build a new gem project using jeweler"
	echo "jewel_repo [name]      : build a new gem project using jeweler and set up repository for it on github"
				
	echo "gbuild                 : build a new gem from a named gem specification file"		
	echo "gem_push               : push gem to gemcutter"			
	echo "manf                   : create gem manifest"		
	echo "rgem                   : create gem from manifest"
	echo "release_gem            : release gem to gemcutter"				
	echo "gem_version            : display gem version"				
	echo "gem_init_version       : set gem initial version"					
		
	echo "gem_inc_major          : increase major version of gem"
	echo "gem_inc_minor          : increase major version of gem"
	echo "gem_patch              : increase patch version of gem"		

	echo "gem_install            : install gem (jewel)"			
	echo "gem_check_depend       : check all dependencies of gem"				
		
	echo "gfind [name]           : find named gem"		
	echo "glist                  : list all gems installed"		
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


function release_gem {
	rake gemcutter:release
}

function gem_version {
	rake version	
}

function jewel_repo {
  	name=$1
  	shift 1	
	jewel $name --create-repo	
}

function jewel {
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

function gfind {
  	name=$1
  	shift 1	
	gem list $name
}

function gbuild {
  	name=$1
  	shift 1	
	gem build $name.gemspec
}

function gem_push {
  	name=$1
  	shift 1	
	gem push $name.gem
}


function glist {
	gem list 
}


function gin {
  	name=$1
  	shift 1	
	gem install $name.gem --local	
}

function sudo_gin {
  	name=$1
  	shift 1	
	sudo gem install $name.gem --local	
}


function gun {
  	name=$1
  	shift 1	
	sudo gem uninstall $name
}

function manf {
	rake manifest	
}

function rgem {
	rake gem
}
