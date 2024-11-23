extends GameObject
class_name Character

@export var dialogue: Array[String]

func _applicable_verbs(verb: String):
	match verb:
		'TALK':
			return talk()
	# check base object verbs
	var try_generic_verbs: String = super._applicable_verbs(verb)
	if try_generic_verbs: return try_generic_verbs
	return 'This item cannot be used in this way'


func get_inventory() -> Array:
	return get_children() as Array

func talk():
	if dialogue.size() == 0:
		return display_name+ ' has nothing to say'
	
	return dialogue[0]
