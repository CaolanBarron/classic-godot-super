extends GameObject
class_name Location

# This object has the following keys: 
# description
# entrance_desc
# location(node), 
# locked_by(string)
# names(Array), 
@export var directions: Array[Resource] 


func _ready():
	# Validate variables exist
	if directions.size() == 0:
		printerr(name + ' is missing locations.')
		return 
	for direction: Direction in directions:
		if !direction.names:
			printerr(name + ': Direction is missing name')
		if !direction.location:
			printerr(name + ': Direction is missing location')
		if !direction.scene_description:
			printerr(name + ': Direction is missing scene description')
		if !direction.entrance_description:
			printerr(name + ': Direction is missing an entrance_description')

func find_direction(command):
	for direction in directions:
		for dir_name in direction.names:
			for word in command:
				if word == dir_name:
					return direction
