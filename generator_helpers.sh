function rails3_generator {
  	generator_name=$1
    gem_name=gem_$generator_name
  	shift 1	
	script/generate generator $generator_name
	cd lib/generators
	# create jewel
	jewel_build $gem_name
	cd lib
	# remove default rb file
	# create directory structure for generator
	rm *.rb
	mkdir generators
	# go to top dir	
	cd ../..
	# # move generator into jewel
	mv $generator_name $gem_name/lib/generators
	echo "Set in Rakefile: gem.files=Dir['lib/**/*.rb']"
	echo "Add template files to /templates dir"
	echo "When done: $ jewel_install"
	echo "Then add: gem '$name' to Gemfile and then to install"
	echo "$ gem bundle"
	mate $gem_name	
}
