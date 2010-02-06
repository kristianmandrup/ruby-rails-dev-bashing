# alterntively use rails BDD template!
function rails_gen_rspec {
	generate rspec	
	generate cucumber	
}

function new_steps {
	name=$1
	touch "features/step_definitions/${name}_steps.rb"
}
