extends Node
class_name InputParser

@onready var player: Player = %Player

var _verbs = {
	'ATTACK' = ['KILL', 'HIT'], 
	'TALK' = ['SPEAK'], 
	'LOOK' = ['EXAMINE'], 
	'WALK' = [],
	'READ' = ['EXAMINE']
}

func _ready():
	# Validate dependencies
	if !player:
		printerr('Input parser does not have a reference to the player')

func _find_verb(word: String):
	print(word)
	if word in _verbs:
		return word
	for key in _verbs.keys():
		for synonym in _verbs[key]:
			if word == synonym:
				return key
				
func _find_object(word, object):
	pass


func parse_command(command: String):
	# Split the string into words
	
	# Find the verb
	var found_verb = _find_verb(command.split(' ')[0].to_upper())
	if !found_verb:
			return 'Im not sure what you are trying to do'
	
	# TODO: check for special verbs that dont use objects 
	
	# Find the main object
	var surrounding_objects = player.find_surrounding_objects()
	var found_objects = []
	for word in command.split(' '):
		var found_object = _find_object(word, surrounding_objects)
		if found_object: found_objects.push(found_object)
	
	# TODO: If found objects is empty. Use Verb object question function
	
	# TODO: if an object is found check if the verb applies to object. Respond if not
	
	# TODO: If the action requires a secondary object check if it exists
	
	# TODO: If the secondary object does not exist ask what they would like to use
	
	# TODO: if the secondary object doeds not apply then respond accordingly
	
	
	return ''
