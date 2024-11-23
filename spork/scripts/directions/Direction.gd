extends Resource
class_name Direction

# This object has the following keys: 
# scene_description: Describe the direction
# entrance_description: Describe going in that direction
# location(node), 
# locked_by(string)
# names(Array): Synonyms

@export var scene_description : String
@export var entrance_description : String
@export var location : NodePath
@export var names : Array[String]
@export var locked_by : String

func _init():
	scene_description = ''
	entrance_description = ''
	location = NodePath('')
	names = []
	locked_by = ''
