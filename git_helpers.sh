export GIT_EDITOR=mate
export EDITOR=mate
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
	git_latest
	gpush
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
# Tag
#=======================

function git_tag {
	tag_name=$1
	branch_name=$2
	shift 2
	echo "Tagging branch $branch_name as '$tag_name'" 
	git tag $tag_name $branch_name
	git tag
}

#=======================
# Patch
#=======================

# Checkout branch [name]
function git_patch {
	git add -p	
}


#=======================
# Branch
#=======================

function list_branches {
	git branch
}

function rename_branch {
    old_name=$1
	new_name$2
    shift 2
	echo "Renaming branch '$old_name' to '$new_name'"
	git branch -m master mymaster
}

function rename_master_branch {
    name=$1
    shift 1
	echo "Renaming 'master' branch to '$name'"
	git branch -m master $branch
}

# create new branch

function git_new_branch_go {
    name=$1
    shift 1
	echo "Creating new branch $name"
	git branch -b $name
}

function git_new_branch {
    name=$1
    shift 1
	echo "Creating new branch $name"
	git branch $name
}


# create branch from master
function git_branch_f_master {
    name=$1
    shift 1
	echo "Creating branch $name from master"
	git branch $name master
}

function git_branch_f_master_go {
    name=$1
    shift 1
	echo "Creating branch $name from master"
	git branch -b $name master
}


# Checkout branch [name]
function git_get_branch {
    name=$1
    shift 1
	git checkout $name	
}

function git_remove_last {
	git reset --hard HEAD^
}

# cherry-pick
function git_pick {
    name=$1
	pick=$2
    shift 1
	git_get_branch $name
	echo "Cherry-picking '$pick'"	
	git cherry-pick $pick	
}

function git_pick_commit {
	git_pick $@
	git commit
}

# switch branch to master
function git_get_master {
	echo "Get master branch"
	git checkout master	
}

function git_merge_w_master {
    name=$1
    shift 1
	git_get_master
	echo "Merging '$name' with master branch"	
	git merge $name	
}

function git_squash_merge_w_master {
    name=$1
    shift 1
	git_get_master
	echo "Squash merging '$name' with master branch"	
	git merge --squash $name	
}	

# merge branch with master branch
function git_merge_branch_master {
    name=$1
    shift 1
	git_get_master
	echo "Merging '$name' with master branch"	
	git pull . $name	
}

function git_rebase_branch {
    branch=$1
    shift 1
	echo "Rebase current branch with $branch"
	git rebase $branch	
}

function git_merge_branch_master {
	git_get_master
	git_rebase_branch $branch
	git_delete_branch $branch
}
	
function git_branch_from_tag {
    branch=$1
    tag=$2
    shift 2
	echo "Create branch $branch from tag $tag"
	git branch $branch $tag
	git_get_branch		
}		
	
function git_delete_branch {
    branch=$1
    shift 1
	echo "Deleting branch $branch"
	git branch -d $branch	
	
}	
	
# merge master branch with current branch
function git_merge_master_w_current {
	echo "Merging master branch with current branch"
	git rebase master	
}

# merge master branch
function git_merge_master {
	git merge master
}


#=======================
# Clone
#=======================
function git_clone {
  echo "Git clone"
  git clone $@
}

function git_clone_hub {
  name=$1
  pl_name=$2
  shift 2
  echo "Git clone '$pl_name' from github at '$name' "
  git clone git://github.com/$name/$pl_name.git
}

function git_clone_my_hub {
  name=$1
  shift 1
  echo "Git clone own project from github '$name'"
  git clone git@github.com:$GITHUB_NAME/$name.git
}

#=======================
# Move
#=======================

function git_move {
	$original_file=$1
	$new_file=$2
	shift 2
	echo "Git moving $original_file --> $new_file"
	git mv $original_file $new_file
	git_stat
}


#=======================
# Diff
#=======================

function git_diff_worktree {
	git diff
}

function git_diff_staging {
	git diff --cached
}

function git_diff_repo {
	git diff HEAD
}


#=======================
# Misc
#=======================

function git_archive_tag {
	$tag=$1
	$name=$2
	$format=$3	
	shift 3
	echo "Archiving tag $tag to $name.$format.gzip"
	git archive --format=$format --prefix=$name-$tag/ $tag | gzip > $name-$tag.$format.gzip
}

function git_latest {
	git log -1
}

function git_pretty {
	git log --pretty=oneline
}

function git_stat {
	git status
}


function github_config {
  	user=$1
	token=$2
  	shift 2
	git config --global github.user $user
	git config --global github.token $token	
	# turn on color coding!
	git config --global color.ui "auto"	
	git config --global core.editor "mate"		
}








