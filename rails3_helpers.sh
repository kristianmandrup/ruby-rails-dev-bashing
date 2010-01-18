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
	sudo gem install bundler thor stympy-mongo-generators mongo_mapper		
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
  ruby $RAILS3 $name $@	
  cd $name 
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
	echo 'gem "rack-mount",    :git => "git://github.com/rails/rack-mount.git"' >> Gemfile
	echo 'gem "rack-test",     "~> 0.5.0"' >> Gemfile
	echo 'gem "erubis",        "~> 2.6.0"' >> Gemfile
	echo 'gem "rails", "3.0.pre", :git => "git://github.com/rails/rails.git"' >> Gemfile

	# mongo-mapper
	echo 'gem "mongo"' >> Gemfile
	echo 'gem "mongo_ext"' >> Gemfile 
	echo 'gem "mongo_mapper",  "~> 0.6.10 "' >> Gemfile	
			 
}