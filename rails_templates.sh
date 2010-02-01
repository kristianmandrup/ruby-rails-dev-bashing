export RAILS_TEMPLATES_HOME=~/rails-templates
export RAILS_TEMPLATES_GITHUB=http://github.com/kristianmandrup/rails-templates/raw/master

function rails_app {
	template=$1
  	appname=$2
  	shift 2
  	rails $appname -m $RAILS_TEMPLATES_GITHUB/$template.rb $@
}

function rails_template {
  	template=$1	
	rake rails:template LOCATION=$RAILS_TEMPLATES_HOME/$template.rb
}

function railsapp_local {
  	template=$1
  	appname=$2
  	shift 2
	rails $appname -m $RAILS_TEMPLATES_HOME/$template.rb $@
}	
