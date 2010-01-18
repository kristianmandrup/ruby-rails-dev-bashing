function testing_help {
    context=$1
    shift 1	
	if [[ $context == '' ]]		 		
	then 
		echo "Gem testing shortcut commands:"
		echo ""		
		echo ""

		echo "============================================================================"		
		echo "testing"
		echo "============================================================================"								
		echo "run_cucumber       : run all Cucumber features"
		echo "run_cucumber_ok    : run Cucumber features that should pass"
		echo "run_cucumber_wip   : run all Cucumber features in-progress"		
		echo "run_tests          : run Unit tests"
		echo "run_specs          : run RSpecs "
		
		
		echo "============================================================================"		
		echo "cucumber"
		echo "============================================================================"
		echo "i_func_test            : install functional testing frameworks (Ruby & Rails)"			
		echo "i_jeweler              : install jeweler and gemcutter"			
	fi
}

#=======================
# Testing
#=======================

function run_cucumber {
	rake cucumber:all  # Run all features
}

function run_cucumber_ok {
	rake cucumber:ok   # Run features that should pass
}

function run_cucumber_wip {
	rake cucumber:wip  # Run features that are being worked on
}

function run_tests {
	rake test
}

function run_specs {
	rake spec
}

#=======================
# Cucumber
#=======================

function setup_cucumber {
	ruby script/generate cucumber
}

function setup_cucumber_spork {
	script/generate cucumber --spork
}

function feature {
	script/generate feature $name $@
}

function autofeature {
	AUTOFEATURE=true autospec
}


