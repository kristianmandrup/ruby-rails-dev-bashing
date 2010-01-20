function rls3_install {
	git clone git://github.com/rails/rails.git
	cd rails
	rls3_submodules_install
	sudo rake install
	rails -v
}

function rls3_submodules_install {
	git submodule init
	git submodule update
	
}

function rls3_gems_install {
	# mongo mapper model generator	
	sudo gem install bundler thor 
	sudo gem install rack rake	
	mongo_db_install
	gems_server_install
}

function mongo_db_install {
	curl -s http://gist.github.com/265272.txt | bash
	
	# sudo port mongodb
	# mongo_db_config
	# sudo launchctl load /Library/LaunchDaemons/org.mongodb.mongod.plist
	# sudo sh -c 'echo "/usr/local/mongodb/bin" > /etc/paths.d/mongodb'
	# 
	# sudo gem install stympy-mongo-generators mongo_mapper
	
	
}	

function mongo_db_config {
	cp templates/mongodb/mongod.conf /usr/local/mongodb/mongod.conf 
	cp templates/mongodb/mongodb.plist /Library/LaunchDaemons/org.mongodb.mongod.plist
}

function db_install {
	sudo port mysql5 +server
	sudo port sqlite3 sqlite3-ruby		
}

function gems_server_install {
	sudo gem install thin mongrel	
}

function rails3_clean_install {	
	rls3_install	
	db_install
	rls3_gems_install
}



function rls3_sproutcore {
  rls3_app $@
  rls3_sproutcore_app $@
}

function rls3_app {
  name=$1
  shift 1
  echo "Generating RAILS app: $name"
  pwd
  rails $name $@	
  cd $name 
}

function rls3_app_full {
	rls3_app
	rgit3_ignore	
	rls3_gemfile
	gem bundle
}

function rls3_sproutcore_app {
  name=$1
  shift 1
  echo "Generating sproutcore app: $name"
  sc-init $name
  mv $name sproutcore	
}

function remove {
	if [ -f $1 ]
	then
		rm -rf $1
	fi
}

function rls3_mongo_mdl {
	script/generate mongo_model $1 $@  
}

function rls3_gemfile {
	remove Gemfile	
	echo 'gem "arel", "0.2.pre", :git => "git://github.com/rails/arel.git"' >> Gemfile
	echo 'gem "rack", "1.1.0", :git => "git://github.com/rails/rack.git"' >> Gemfile
	echo 'gem "rack-mount"' >> Gemfile
	echo 'gem "rack-test",     "~> 0.5.0"' >> Gemfile
	echo 'gem "erubis",        "~> 2.6.0"' >> Gemfile
	echo 'gem "rails", "3.0.pre", :git => "git://github.com/rails/rails.git"' >> Gemfile

	# mongo DB and mapper
	echo '# mongo DB and mapper' >> Gemfile
	echo 'gem "mongo", "~> 0.18.2"' >> Gemfile
	echo 'gem "mongo_ext", "~> 0.18.2"' >> Gemfile 
	echo 'gem "mongo_mapper",  "~> 0.6.10 "' >> Gemfile	
			 
}