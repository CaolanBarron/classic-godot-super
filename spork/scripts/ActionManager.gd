extends Node
class_name ActionManager

@onready var player: Player = %Player

func global_verbs(verb: String, full_command):
	match(verb):
		'INVENTORY':
			return player.display_inventory()
		'WALK':
			return walk(full_command)
		'ATTACK':
			return hit(full_command)
	return ''



func walk(command):
	var current_position = player.get_parent() as Location
	if !(current_position is Location):
		printerr('THE PLAYERS ISNT IN A LOCATION???')
	
	var found_direction = current_position.find_direction(command)
	
	if !found_direction:
		#TODO: check if they used a direction and say theres nothing that way
		return 'Where would you like to go?'
	
	if 'locked_by' in found_direction && found_direction.locked_by:
		var player_inventory = player.get_inventory()
		var found_key = false
		for item in player_inventory:
			if item.name == found_direction['locked_by']:
				found_key = true
		
		if !found_key:
			return 'This way is locked, you must find the key.'
		# This UNLOCKS the direction
		found_direction.erase('locked_by')

	player.reparent(current_position.get_node(found_direction.location))
	SignalManager.describe_environment.emit()
	
	return 'LOCATION_CHANGED'

func hit(command):
	for word in command:
		if word == 'GRIDDY':
			return 'Your moves impress nobody. But you had a good time'
	return ''
