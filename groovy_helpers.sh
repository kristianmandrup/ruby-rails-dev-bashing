# Groovy/Grails

function groovy_help {
	context=$1
	shift	
	if [[ $context == '' ]]		 		
	then 	
		echo "Groovy shortcut commands:"	
		echo "Context specifiers:   console, pack"
		echo ""	
		echo "============================================================================"		
		echo "console"
		echo "============================================================================"						
		echo "grv_cons     : Groovy console"	
        echo "grl_cons     : Grails console"

		echo "============================================================================"		
		echo "pack"
		echo "============================================================================"						
        echo "grl_war [test|dev|prod] : Create grails WAR file for deployment (default:prod)"			
	fi
	
	if [[ $context == 'console' ]] 
	then
		echo "============================================================================"		
		echo "console"
		echo "============================================================================"						
		echo "grv_cons     : Groovy console"	
        echo "grl_cons     : Grails console"	
		echo "grl_shl      : Grails shell"	
	fi	

	if [[ $context == 'pack' ]] 
	then	
	echo "============================================================================"		
	echo "pack"
	echo "============================================================================"						
    echo "grl_war     : Create grails WAR file for deployment"			
	fi
}

#=======================
# Console
#=======================

function grv_cons { 
	echo "Groovy console"
	groovyConsole
}

function grl_cons { 
	echo "Grails console"
	grails console
}

function grl_shl { 
	echo "Grails interactive shell"
	grails shell
}

function grl_war { 
	name=$1
	shift 1
	echo "Create Grails war for: $name"
	grails $name war
}