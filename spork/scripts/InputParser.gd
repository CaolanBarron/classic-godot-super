extends Node
class_name InputParser

@onready var player: Player = %Player
@onready var action_manager: ActionManager = %ActionManager

var _verbs = {
	'ATTACK' = ['KILL', 'HIT'], 
	'TALK' = ['SPEAK'], 
	'LOOK' = ['EXAMINE'], 
	'WALK' = ['EXIT', 'LEAVE', 'ENTER', 'GO', 'MOVE', 'STROLL', 'TRAVEL', 'SAUNTER'],
	'READ' = [],
	'OPEN' = ['UNLOCK'],
	'TAKE' = ['RETRIEVE', 'LIFT', 'PICK', 'GATHER', 'COLLECT'],
	'DROP' = ['DISCARD'],
	'INVENTORY' = ['POCKETS'],
	'DANCE' = ['GRIDDY']
}

func _ready():
	# Validate dependencies
	if !player:
		printerr('Input parser does not have a reference to the player')


func _find_verb(word: String):
	if word in _verbs:
		return word
	for key in _verbs.keys():
		for synonym in _verbs[key]:
			if word == synonym:
				return key


func _find_object(word: String, objects: Array):
	# for each object:
	for object:GameObject in objects:
		#Check if the word matches the objects display name
		if object.display_name.to_upper() == word:
			return object
	#	Check if the word is in the list of objects synonyms
		for synonym in object.synonyms:
			if synonym == word:
				return object



func parse_command(command: String):
	# Split the string into words
	var command_array = command.to_upper().split(' ')
	# Find the verb
	var found_verb = _find_verb(command_array[0])
	if !found_verb:
			return 'Im not sure what you are trying to do'
	
	# Check for special verbs that dont use objects 
	var game_verb = action_manager.global_verbs(found_verb, command_array)
	if game_verb:
		if game_verb == 'LOCATION_CHANGED':
			return
		return game_verb
	
	# Find the main object
	var surrounding_objects = player.find_usable_objects()

	var found_objects = []
	for word in command_array:
		var found_object = _find_object(word, surrounding_objects)
		if found_object: found_objects.append(found_object)
	# In the future I may want to do a check if no objects are said for generic commands
	# TODO: If found objects is empty. Use Verb object question function
	if found_objects.size() == 0: return 'What would you like to ' + found_verb
	# TODO: if an object is found check if the verb applies to object. Respond if not
	var used_verb = (found_objects[0] as GameObject)._applicable_verbs(found_verb)
	if used_verb: return used_verb
	# TODO: If the action requires a secondary object check if it exists
	
	# TODO: If the secondary object does not exist ask what they would like to use
	
	# TODO: if the secondary object doeds not apply then respond accordingly
	
	
	return ''

