extends GameObject
class_name Location

# This object has the following keys: 
# names(Array), 
# location(node), 
# description (string)
# locked_by(string)
@export var directions: Array[Dictionary] 

func _ready():
	# Validate variables exist
	if directions.size() == 0:
		printerr(name + ' is missing locations.')
		return 
		
	for direction in directions:
		if 'names' not in direction:
			printerr(name + ': Direction is missing name')
		else:
			if !(direction['names'] is Array):
				printerr(name +': Name should be a string')
		if 'location' not in direction:
			printerr(name + ': Direction is missing location')
		else:
			if !(direction['location'] is NodePath):
				printerr(name + ': Location should be a NodePath')
		if 'description' not in direction:
			printerr(name + ': Direction is missing description')
		else:
			if !(direction['description'] is String):
				printerr(name + ': Description should be a string')
		if 'entrance_desc' not in direction:
			printerr(name + ': Direction is missing an entrance_desc')
		else:
			if !(direction['entrance_desc'] is String):
				printerr(name + ': Entrance description should be a string')

func find_direction(command):
	for direction in directions:
		for name in direction.names:
			for word in command:
				if word == name:
					return direction
