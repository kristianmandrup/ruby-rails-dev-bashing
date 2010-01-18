# Install

function install_help {
    context=$1
    shift 1	
	if [[ $context == '' ]]		 		
	then 
		echo "Gem install shortcut commands:"
		echo ""		
		echo ""
		echo "============================================================================"		
		echo "install"
		echo "============================================================================"
		echo "i_func_test            : install functional testing frameworks (Ruby & Rails)"			
		echo "i_jeweler              : install jeweler and gemcutter"			
	fi
}
#=======================
# Install
#=======================

function i_func_test {
	sgin rspec rspec-rails cucumber webrat pickle autotest-rails
}

function i_jeweler {
	sgin jeweler gemcutter
}
