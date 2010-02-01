# Install

function uninstall_macports {
	sudo port -f uninstall installed	
	sudo rm -rf \
	    /opt/local \
	    /Applications/DarwinPorts \
	    /Applications/MacPorts \
	    /Library/LaunchDaemons/org.macports.* \
	    /Library/Receipts/DarwinPorts*.pkg \
	    /Library/Receipts/MacPorts*.pkg \
	    /Library/StartupItems/DarwinPortsStartup \
	    /Library/Tcl/darwinports1.0 \
	    /Library/Tcl/macports1.0 \
	    ~/.macports	
}

function uninstall_fink {
	sudo rm -rf /sw
	sudo rm -rf /usr/X11R6 /etc/X11 /Applications/XDarwin.app	
}

function install_rubygems {
    curl -O http://gemcutter-production.s3.amazonaws.com/rubygems/rubygems-1.3.5.tgz
    tar xzvf rubygems-1.3.5.tgz
    rubygems-1.3.5
    ruby setup.rb
    sudo gem update
    rm -rf rubygems-1.3.5.tgz
    rm -rf rubygems-1.3.5	
}

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
		echo "install_func_test_gems       : install functional testing frameworks (Ruby & Rails)"			
		echo "install_jeweler              : install jeweler and gemcutter"			
	fi
}
#=======================
# Install
#=======================

function install_mongo_db_port {
	sudo port mongodb install git-core unittest-cpp boost pcre spidermonkey scons
}

function install_homebrew {
	sudo chown -R `whoami` /usr/local
	
	cd /usr/local
	git init
	git remote add origin git://github.com/mxcl/homebrew.git
	git pull origin master
}

function uninstall_homebrew {
	cd `brew --prefix`
	rm -rf Cellar
	brew prune
	rm -rf Library .git .gitignore bin/brew README.md
}

function install_all {
	sudo port selfupdate
	# sudo port install mysql5 +server
	# sudo port install ruby
	sudo port install rb-rubygems
	sudo port install rb-termios
	sudo port install rb-mysql
	# sudo port install subversion +tools
	# sudo ln -s /opt/local/var/run/mysql5/mysqld.sock /tmp/mysql.sock
	# sudo launchctl load -w /Library/LaunchDaemons/org.macports.mysql5.plist
	sudo mysql_install_db5 --user=mysql 
}

