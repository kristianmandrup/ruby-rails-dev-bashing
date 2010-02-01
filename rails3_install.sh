function rls3_install {
	if [ ! -d ~/rails ]
	then
	  	git clone git://github.com/rails/rails.git
	fi
	install_rubygems
	reinstall_rails
}

function reinstall_rails {
	cd ~/rails
	rls3_submodules_install
	sudo rake install
	rails -v	
}

function rls3_submodules_install {
	git submodule init
	git submodule update
}


function rails3_full_install {	
	rls3_install	
	mongo_db_install
	# db_install
	rls3_gems_install
}

function rls3_gems_install {
	gem_install bundler thor rack rake	
	gems_rails_server_install
	gems_test_install
	gems_jeweler_install
	gems_test_install
}

function db_install {
	sudo port mysql5 +server
	sudo port sqlite3 sqlite3-ruby		
}

function gems_test_install {
	gem_install rspec rspec-rails cucumber cucumber-rails webrat pickle autotest-rails
}

function gems_jeweler_install {
	gem_install gemcutter jeweler 
}

function gems_rails_server_install {
	gem_install thin mongrel mongrel_cluster	
}
