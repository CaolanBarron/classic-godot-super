extends GameObject
class_name Item

@export var can_pick_up : bool = false
@export var can_open : bool = false
@export var is_open : bool = false
@export var can_lock: bool = false
@export var is_locked: bool = false

 
func _applicable_verbs(verb: String) -> String:
	match verb:
		'TAKE':
			return pick_up()
		'DROP':
			return drop()
	
	# check base object verbs
	var try_generic_verbs: String = super._applicable_verbs(verb)
	if try_generic_verbs: return try_generic_verbs
	return 'This item cannot be used in this way'
	




func pick_up():
	if !can_pick_up:
		return 'This item cannot be picked up'
	
	reparent(player)
	return 'The ' + display_name + ' is now in your inventory.'

func drop():
	if !can_pick_up:
		return 'You shouldnt even have this'
		
	if get_parent().name != 'Player':
		return 'You are not currently holding this item'
	
	var location = player.get_parent()
	reparent(location)
	return 'You dropped the ' + display_name
