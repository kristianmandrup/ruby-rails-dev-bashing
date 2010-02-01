export RAILS3_TEMPLATES_HOME=~/rails3-templates
export RAILS3_TEMPLATES_GITHUB=http://github.com/kristianmandrup/rails3-templates/raw/master

# apply template

function rails3_template {
  	template=$1	
	rake rails:template LOCATION=$RAILS3_TEMPLATES_HOME/$template.rb
}

# app using github template (default)

function rails3_app_template {
  template=$1
  appname=$2
  shift 2
  rails $appname -m $RAILS3_TEMPLATES_GITHUB/$template.rb $@
}

function nifty_app_template {
  template=$1
  appname=$2
  shift 2
  nifty_app $appname -m $RAILS3_TEMPLATES_GITHUB/$template.rb $@
}

# app using local template

function rails3_app_template_local {
  	template=$1
  	appname=$2
  	shift 2
	rails $appname -m $RAILS3_TEMPLATES_HOME/$template.rb $@
}	

function nifty_app_template_local {
  template=$1
  appname=$2
  shift 2
  nifty_app $appname -m $RAILS3_TEMPLATES_HOME/$template.rb $@
}
