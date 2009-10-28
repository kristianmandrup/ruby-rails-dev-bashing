# Groovy/Grails

function groovy_help {
	context=$1
	shift	
	if [[ $context == '' ]]		 		
	then 	
		echo "Groovy shortcut commands:"	
		echo "Context specifiers:   app, plugin"
		echo ""	
		echo "grv_cons                    : Groovy console"	
        echo "grl_cons                    : Grails console"	
	fi
}


function grv_cons { 
	echo "Groovy console"
	groovyConsole
}

function grl_cons { 
	echo "Grails console"
	grails console
}
