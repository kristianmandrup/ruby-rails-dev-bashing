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

