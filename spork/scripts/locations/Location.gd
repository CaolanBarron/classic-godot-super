extends GameObject
class_name Location

@export var directions: Array[Dictionary] 

func _ready():
	# Validate variables exist
	if directions.size() == 0:
		printerr(name + ' is missing locations.')
	else:
		for direction in directions:
			if 'name' not in direction:
				printerr(name + ': Direction is missing name')
			else:
				if !(direction['name'] is String):
					printerr(name +': Name should be a string')
			if 'location' not in direction:
				printerr(name + ': Direction is missing location')
			else:
				if !(direction['location'] is NodePath):
					printerr(name + ': Location should be a NodePath')
