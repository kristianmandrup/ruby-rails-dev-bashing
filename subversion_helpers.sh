# SUBVERSION

function svn_help {
  context=$1
  shift 1	
	
	if [[ $context == '' ]]		 		
	then 
		echo "Subversion shortcut commands:"
		echo "Context specifiers: sync"
		echo ""
		echo "scmit [msg]                : Subversion commit with latest additions"	
		echo "scmit_all [msg]            : Subversion add all in current location and commit"	
		echo "svn_co [registry_location] : Checkout named svn project from registry"	
		echo "spush [msg]                : Push (commit) svn changes to registry"
		echo "spull                      : Pull (update) svn project from registry"
	fi

	if [[ $context == 'context' ]]		 		
	then 
		echo "Subversion help context specifiers   : sync"
	fi
		
	if [[ $context == 'sync' ]] 
	then
	  	echo "scmit [msg]                : Subversion commit with latest additions"	
		echo "scmit_all [msg]            : Subversion add all in current location and commit"	  	
	  	echo "svn_co [registry_location] : Checkout named svn project from registry"	
	  	echo "spush [msg]                : Push (commit) svn changes to registry"
	  	echo "spull                      : Pull (update) svn project from registry"
	fi 
	
}

function scmit {
    msg=$1
    shift 1
    svn commit -m "$msg"
}


function scmit_all {
    msg=$1
    shift 1
    svn add .
    svn commit -m "$msg"
}

function svn_co {
    registry=$1
    shift 1
    svn checkout $registry
}

function spull {
  echo "SVN: pull (update)"
  svn up
}

function gpush {
  msg=$1
  shift 1
  echo "SVN: push"
  svn_cmit -m "$msg"
}


