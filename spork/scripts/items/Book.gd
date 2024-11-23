extends Item
class_name Book

@export var book_contents: Array[String]

func _applicable_verbs(verb: String):
	match verb:
		'READ':
			return book_contents
			
	# Check base object verbs
	var try_generic_verbs: String = super._applicable_verbs(verb)
	if try_generic_verbs: return try_generic_verbs
	return 'The book cant be used in this way'
