function rails3_sproutcore {
  echo "Generating RAILS app: $name with sproutcore app inside"	
  nifty_app $@
  sproutcore_inside_rails $@
}

#=======================
# Generate
#=======================

function generator {
	script/generate generator $1
}

#=======================
# App
#=======================

function rails3_basic_app {
  name=$1
  shift 1
  echo "Generating RAILS app: $name"
  pwd
  rails $name $@	
  cd $name 
}

function rails3_app_full {
	rls3_app $@
	rails3_git_ignore	
	rails3_gemfile
	gem bundle
}

function sproutcore_inside_rails {
  name=$1
  shift 1
  echo "Generating sproutcore app: $name"
  sc-init $name
  mv $name sproutcore	
}

function rails3_gemfile {
	remove Gemfile	
	# mongo DB and mapper
	echo 'gem "rails", "3.0.pre"' >> Gemfile	
}
