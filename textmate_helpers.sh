# TEXTMATE

function tm_help {
	echo "Textmate shortcut commands:"
	echo "txb_instl [name]        : install textmate bundle from TextMate SVN repository"	
}

function txb_instl {
  	name=$1
  	shift 1	
	tmb_dir="/Library/Application\ Support/TextMate/Bundles"
	echo "Requires prexisting folder: mkdir -p"
	if [ ! -d $tmb_dir ] 
	then 
		echo "Creating Textmate/Bundles dir"
		mkdir -p "/Library/Application\ Support/TextMate/Bundles"
	fi	
	cd "/Library/Application\ Support/TextMate/Bundles"
	svn co http://svn.textmate.org/trunk/Bundles/$name
	osascript -e 'tell app "TextMate" to reload bundles'
}