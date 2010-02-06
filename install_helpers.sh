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

function install_mpfr {
	lib_name=$1
	if [ ! -d $lib_name ] 
	then
		if [ ! -f $lib_name.tar.bz2 ]; then	
			curl -O http://www.mpfr.org/mpfr-current/$lib_name.tar.bz2
		fi
		tar xjf $lib_name.tar.bz2
		cd $lib_name
		./configure
	 	make	
		make install
		cd ..
	fi
}

function install_mpc {
	lib_name=$1	
	if [ ! -d $lib_name ] 
	then
		if [ ! -f $lib_name.tar.gz ]; then
			curl -O http://www.multiprecision.org/mpc/download/$lib_name.tar.gz
		fi
		tar xjf $lib_name.tar.gz
		cd $lib_name
		./configure
	 	make	
		make install
		cd ..
	fi
}

function install_gmp {
	lib_name=$1		
	if [ ! -d $lib_name ]
	then
		if [ ! -f $lib_name.tar.bz2 ]; then	
			curl -O ftp://ftp.gmplib.org/pub/gmp-5.0.0/$lib_name.tar.bz2
		fi
		tar xjf $lib_name.tar.bz2
		cd $lib_name
		./configure
	 	make	
		make install	
		cd ..
	fi
}

function install_gcc {
	lib_name=$1			
	if [ ! -d $lib_name ]	
	then
		if [ ! -f $lib_name.tar.gz ]; then		
			curl -O http://ftp.download-by.net/gnu/gnu/gcc/gcc-4.4.3/$lib_name.tar.gz
		fi	
		tar xjf $lib_name.tar.gz	
		echo "to use installed libs 'mpfr' and 'mpc' outside default install locations use arguments pointing to lib locations"
		echo "--with-mpfr [mpfr lib location] --with-mpc [mpc lib location]"
		#  
	 	mkdir build
	 	cd build
	 	../gcc-*/configure --enable-languages=c,c++
	 	make
	 	make install
		cd ..
	fi
}


# http://gist.github.com/292638.txt
function install_gcc_443 {
	install_mpfr mpfr-2.4.2	
	install_mpc mpc-0.8.1
	install_gmp gmp-5.0.0
	install_gcc	gcc-4.4.3
	
	# cleanup
	rm mpfr-2.4.2.tar.bz2 mpc-0.8.1.tar.gz gmp-5.0.0.tar.bz2 gcc-4.4.3.tar.gz	
	rm -rf mpfr-2.4.2 mpc-0.8.1 gmp-5.0.0 gcc-4.4.3
}

function install_rvm {
	sudo gem install rvm -s http://gemcutter.org/
	rvm-install
	rvm install 1.9.1
	rvm use 1.9.1
	ruby -v
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

function print_all_gems {
	gem list | cut -d" " -f1
}

function remove_gem_dirs {
	sudo rm -rf ~/.gem	
	sudo rm -rf ~/.ri	
}

function uninstall_all_gems {
	print_all_gems | xargs gem uninstall -aIx		
}

function reinstall_all_gems {
	print_all_gems > installed_gems
	cat installed_gems | xargs gem uninstall -aIx	
	cat installed_gems | xargs sudo gem install
}

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


function install_homebrew_ruby {
	brew install ruby
	export PATH=/Users/kristianconsult/.gem/ruby/1.9.1/bin:$PATH
}

function install_homebrew_alt {
	sudo mkdir -p /usr/local
	sudo chown -R `whoami` /usr/local
	curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz –strip 1 -C /usr/local		
}



function install_mysql {
	brew install mysql
	mysqlinstalldb –basedir=/usr/local/Cellar/mysql/5.1.41	
    export ARCHFLAGS=”-arch i386 -arch x8664”
    gem install mysql – –with-mysql-dir=/usr/local–with-mysql-config=/usr/local/bin/mysqlconfig
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

