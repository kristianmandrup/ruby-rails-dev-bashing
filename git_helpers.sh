# GIT

function git_help {
    context=$1
    shift 1	
	if [[ $context == '' ]]		 		
	then 
		echo "Git shortcut commands:"
		echo "Context specifiers:   branch, sync, clone, project"
		echo ""
		echo "cmit [msg]                : Git commit with latest additions"	
		echo "crb [name]                : Git create named branch"	
		echo "swb [name]                : Git switch to named branch"	
		echo "swb_m                     : Git switch to MASTER branch"			
		echo "git_prj_new [name]        : create app folder with git repository. Push to github account"	
		echo "git_prj [name]            : create new git repository. Push to github account"
		echo "git_exprj [name]          : push existing git repository to github account"	
		echo "gpom                      : Push git project to origin master branch"
		echo "gpush                     : Push git project (fx to origin master branch)"
		echo "gpull                     : Pull git project (fx from origin master branch)"		
		echo "gc [location]             : Git clone project from location"
		echo "gchub [repo] [project]    : Git clone project from named github repository"
		echo "gcmy [project]            : Git clone project from your own github repository"
		echo "rgit_ignore               : Create .gitignore file for rails app"	
	fi

	if [[ $context == 'context' ]]		 		
	then 
		echo "Git help context specifiers   : branch, sync, clone, project"
	fi
	
	if [[ $context == 'branch' ]]		 
	then
		echo "crb [name]                : Git create named branch"	
		echo "swb [name]                : Git switch to named branch"	
		echo "swb_m                     : Git switch to MASTER branch"	
		echo "mb_m [name]               : Git merge named branch into MASTER branch"	
		echo "rb_m                      : Git merge MASTER branch into current branch"					
	fi
	
	if [[ $context == 'project' ]]		 
	then
		echo "git_prj_new [name]        : create app folder with git repository. Push to github account"	
		echo "git_prj [name]            : create new git repository. Push to github account"
		echo "git_exprj [name]          : push existing git repository to github account"	
	fi

	if [[ $context == 'clone' ]]
	then
		echo "gc [location]             : Git clone project from location"
		echo "gchub [repo] [project]    : Git clone project from named github repository"
		echo "gcmy [project]            : Git clone project from your own github repository"
	fi 

	if [[ $context == 'sync' ]] 
	then
		echo "gpom                      : Push git project to origin master branch"
		echo "gpush                     : Push git project (fx to origin master branch)"
		echo "gpull                     : Pull git project (fx from origin master branch)"		
	fi 
	
}


function cmit {
    msg=$1
    shift 1
    git commit -a -m "$msg"
}

function crb {
    name=$1
    shift 1
	git checkout -b $name	
}

function swb {
    name=$1
    shift 1
	git checkout $name	
}

function mb_m {
    name=$1
    shift 1
	swb_m
	echo "Merging '$name' with master branch"	
	git pull . $name	
}

function rb_m {
	echo "Merging master with current branch"
	git rebase master	
}


function swb_m {
	git checkout master	
}

function gmm {
	git merge master
}

		

function git_exprj {
    name=$1
    shift 1
    echo "Pushing Git project '$name' to github"
    git add .
    git commit -m 'first commit'
    git remote add origin git@github.com:$GITHUB_NAME/$name.git
    git push origin master
}

function git_prj {
    name=$1
    shift 1
    echo "Generating Git project '$name' ..."
	rgit_ignore
	echo "Init local repository"
    git init
	echo "Create README"
    touch README
    git add README
    git_exprj $name
}


function git_prj_new {
    name=$1
    shift 1
	echo "Creating directory for '$name'"
    mkdir $name
    cd $name
    git_prj $name
}


function gpom {
  echo "Git: pushing to original master"
  git push origin master
}

function gpull {
  echo "Git: pull"
  git pull
}

function gpush {
  echo "Git: push"
  git push
}


function gc {
  echo "Git clone"
  git clone $@
}

function gchub {
  name=$1
  pl_name=$2
  shift 2
  echo "Git clone '$pl_name' from github at '$name' "
  git clone git://github.com/$name/$pl_name.git
}

function gcmy {
  name=$1
  shift 1
  echo "Git clone own project from github '$name'"
  git clone git@github.com:$GITHUB_NAME/$name.git
}
