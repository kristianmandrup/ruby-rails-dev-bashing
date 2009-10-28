function size { 
	target = $1
	shift 1
	ls -lR $target | awk '{sum += $5} END{print sum}'
}

function ll {
	ls -al
}

