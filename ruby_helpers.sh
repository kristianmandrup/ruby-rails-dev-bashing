function install_readline {
	cd ~/src
	curl -O ftp://ftp.gnu.org/gnu/readline/readline-6.0.tar.gz
	tar xzvf readline-6.0.tar.gz
	cd readline-6.0
	./configure --prefix=/usr/local
	make
	sudo make install
}

function reinstall_ruby_191 {
	cd ~/src
	cd ruby-1.9.1-p376/
	make clean
	autoconf
	./configure --prefix=/usr/local/ --with-readline-dir=/usr/local --enable-shared
	make
	sudo make install	
}

function install_rubygems {
	curl -O http://files.rubyforge.vm.bytemark.co.uk/rubygems/rubygems-1.3.5.tgz
	tar xzvf rubygems-1.3.5.tgz
	cd rubygems-1.3.5
	sudo /usr/local/bin/ruby setup.rb
	cd ..	 
}

function install_ruby_191 {
	cd ~
  	mkdir src
	cd src
	curl -O ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.1-p376.tar.gz
	tar xzvf ruby-1.9.1-p376.tar.gz
	cd ruby-1.9.1-p376/	
	autoconf
	./configure --prefix=/usr/local/ --enable-shared --with-readline-dir=/usr/local	
	install_readline
	cd ~/src	
	cd ruby-1.9.1-p376/		
	make
	reinstall_ruby_191		
	# test ruby version
	which ruby
	ruby -v
}

function ruby_rails_clean_install {
	ruby_19_clean_install	
	rails3_clean_install
}

function remove_ruby_gems {
	ruby=$1	
	sudo rm -rf /opt/local/lib/$ruby	
}

function uninstall_ruby {
	ruby=$1
	sudo port uninstall $ruby
	sudo port clean $ruby
	remove_ruby_gems $ruby
}

function ruby_19_clean_install {
	uninstall_ruby ruby
	uninstall_ruby ruby19
	# remove rake
	sudo rm -rf /opt/local/bin/rake
	
	sudo port install ruby19 +nosuffix
}
