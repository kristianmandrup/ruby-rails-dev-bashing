# GIT

function git_help {
    context=$1
    shift 1	
	if [[ $context == '' ]]		 		
	then 
		echo "Git shortcut commands:"
		echo "Context specifiers:   project, sync, branch, clone, misc"
		echo "- usage: git_help [context]"				
		echo ""
		echo "============================================================================"		
		echo "project"
		echo "============================================================================"				
		echo "git_prj_new [name]         : create app folder with git repo -> github"	
		echo "git_prj [name]             : create new git repository -> github"
		echo "git_exprj [name]           : push git repo -> github"	
		
		echo "============================================================================"		
		echo "sync"
		echo "============================================================================"		
		echo "gc [msg]                   : Git commit with latest additions"	
		echo "gc_all [msg]               : Git add all and commit"	
		echo "gpush                      : Push git project (fx to origin master branch)"
		echo "gpull                      : Pull git project (fx from origin master branch)"		
		echo "gpush_om                   : Push git project to origin master branch"
		
		echo "============================================================================"		
		echo "branch"
		echo "============================================================================"		
		echo "gcb [name]                 : Git create named branch"	
		echo "gsb [name]                 : Git switch to named branch"	
		echo "gsbm                       : Git switch to MASTER branch"			

		echo "============================================================================"		
		echo "clone"
		echo "============================================================================"		
		echo "gcl [location]             : Git clone project from location"
		echo "gcl_hub [repo] [project]   : Git clone project from named github repository"
		echo "gcl_my [project]           : Git clone project from your own github repository"

		echo "============================================================================"		
		echo "misc"
		echo "============================================================================"		
		echo "github_config [user] [token] : configure your github account locally"					
	fi

	if [[ $context == 'context' ]]		 		
	then 
		echo "Context specifiers:   project, sync, branch, clone, misc"
	fi

	if [[ $context == 'project' ]]		 
	then
		echo "============================================================================"		
		echo "project"
		echo "============================================================================"				
		echo "git_prj_new [name]         : create app folder with git repo -> github"	
		echo "git_prj [name]             : create new git repository -> github"
		echo "git_exprj [name]           : push git repo -> github"	
	fi
	
	if [[ $context == 'branch' ]]		 
	then
		echo "============================================================================"		
		echo "branch"
		echo "============================================================================"		
		echo "gcb [name]                 : Git create named branch"	
		echo "gsb [name]                 : Git switch to named branch"	
		echo "gsbm                       : Git switch to MASTER branch"							
		echo "gmbm                       : Git merge branch with MASTER branch"							
		echo "gmmc                       : Git merge MASTER branch with current branch"							
		echo "gmm                        : Git merge MASTER branch (?)"							
	fi		
	
	if [[ $context == 'sync' ]] 
	then
		echo "============================================================================"		
		echo "sync"
		echo "============================================================================"		
		echo "gc [msg]                   : Git commit with latest additions"	
		echo "gc_all [msg]               : Git add all and commit"	
		echo "gpush                      : Push git project (fx to origin master branch)"
		echo "gpull                      : Pull git project (fx from origin master branch)"		
		echo "gpush_m                    : Push git project to origin master branch"
	fi 


	if [[ $context == 'clone' ]]
	then
		echo "============================================================================"		
		echo "clone"
		echo "============================================================================"		
		echo "gcl [location]             : Git clone project from location"
		echo "gcl_hub [repo] [project]   : Git clone project from named github repository"
		echo "gcl_my [project]           : Git clone project from your own github repository"
	fi 

	if [[ $context == 'misc' ]] 
	then
		echo "============================================================================"		
		echo "misc"
		echo "============================================================================"		
		echo "github_config [user] [token] : configure your github account locally"					
	fi
	
}

# project, sync, branch, clone, misc"

#=======================
# Project
#=======================

# create new git project from scratch
function git_prj_new {
    name=$1
    shift 1
	echo "Creating directory for '$name'"
    mkdir $name
    cd $name
    git_prj $name
}

# create new git project from existing folder
function rails_git_prj {
    name=$1
    shift 1
    echo "Generating Git project '$name' ..."
	rails_git_ignore
	echo "Init local repository"
    git init
	echo "Create README"
    touch README
    git add README
    git_exprj $name
}

function git_prj {
    name=$1
    shift 1
    echo "Generating Git project '$name' ..."
	echo "Init local repository"
    git init
	echo "Create README"
    touch README
    git add README
    git_exprj $name
}


# update and push existing git project to github
function git_exprj {
    name=$1
    shift 1
    echo "Pushing Git project '$name' to github"
    git add .
    gc 'first commit'
    git remote add origin git@github.com:$GITHUB_NAME/$name.git
    git push origin master
}


#=======================
# Ignore
#=======================

function rails_git_ignore { 
	echo "Create Rails git .ignore"
	rm -rf .gitignore
	echo .DS_Store >> .gitignore
	echo "log/*.log" >> .gitignore
	echo tmp/**/* >> .gitignore	
	echo config/database.yml >> .gitignore
	echo db/*.sqlite3 >> .gitignore
}

function rails3_git_ignore { 
	echo "Create Rails git .ignore"
	rm -rf .gitignore
	echo ".DS_Store" >> .gitignore
	echo ".rake_tasks~" >> .gitignore
	echo "config/database.yml" >> .gitignore
	echo "doc/api" >> .gitignore
	echo "log/*.log" >> .gitignore
	echo "tmp/**/*" >> .gitignore
	echo "db/*.sqlite3" >> .gitignore
	echo "bin/*" >> .gitignore
	echo "vendor/gems/*" >> .gitignore
	echo "!vendor/gems/cache/" >> .gitignore
}


function jewel_git_ignore { 
	echo "Create Jewel git .ignore"
	rm -rf .gitignore
	echo .DS_Store >> .gitignore
	echo "pkg/*" >> .gitignore
}

function gem_git_ignore { 
	echo "Create Gem git .ignore"
	rm -rf .gitignore
	echo .DS_Store >> .gitignore
	echo "*.gem" >> .gitignore
}

#=======================
# Sync
#=======================

function gc {
    msg=$1
    shift 1
    git commit -am "$msg"
}

function gc_all {
    msg=$1
    shift 1
	git add . 
    gc "$msg"
}

function gpull {
  echo "Git: pull"
  git pull
}

function gpush {
  echo "Git: push"
  git push
}

function gpush_m {
  echo "Git: pushing to original master"
  git push origin master
}


#=======================
# Branch
#=======================

# create branch [name]
function gcb {
    name=$1
    shift 1
	git checkout -b $name	
}

# switch branch to [name]
function gsb {
    name=$1
    shift 1
	git checkout $name	
}

# switch branch to master
function gsbm {
	git checkout master	
}

# merge branch with master branch
function gmbm {
    name=$1
    shift 1
	swb_m
	echo "Merging '$name' with master branch"	
	git pull . $name	
}

# merge master branch with current branch
function gmmc {
	echo "Merging master branch with current branch"
	git rebase master	
}

# merge master branch
function gmm {
	git merge master
}


#=======================
# Clone
#=======================
function gcl {
  echo "Git clone"
  git clone $@
}

function gcl_hub {
  name=$1
  pl_name=$2
  shift 2
  echo "Git clone '$pl_name' from github at '$name' "
  git clone git://github.com/$name/$pl_name.git
}

function gcl_my {
  name=$1
  shift 1
  echo "Git clone own project from github '$name'"
  git clone git@github.com:$GITHUB_NAME/$name.git
}


#=======================
# Misc
#=======================

function github_config {
  	user=$1
	token=$2
  	shift 2
	git config --global github.user $user
	git config --global github.token $token	
}








