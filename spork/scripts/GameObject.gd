extends Node
class_name GameObject

@export var display_name: String
@export var scene_description: String
@export var description: String
@export var synonyms: Array[String]

func _ready():
	# Validate the Game objects variables are defined
	if !display_name:
		printerr(name + ': Missing display name')
	if !scene_description:
		printerr(name + ': Missing scene description')
	if !description:
		printerr(name + ': Missing description')
	if synonyms.size() == 0:
		printerr(name + ': Should have atleast one synonym')


func _applicable_verbs(verb: String) -> String:
	match verb:
		'LOOK': 
			return description
	return ''
