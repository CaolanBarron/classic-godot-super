extends Camera2D

@export 
var player: CharacterBody2D

# WARNING: This would be probably be way better by just adding the width of the 
# screen instead of defining every possibility maybe
# Make a dictionary of a all the x positions for each stage
var camera_points: Dictionary = {0: 0, 1: 858, 2: 1716, 3: 2574, 4: 3432}

var current_camera_point: int = 0

func _process(_delta):
	if !player: return
	
	# TODO: this is bad to lock all this in by a preset camera size
	if player.position.x > position.x + 429:
		if camera_points.has(current_camera_point + 1):
			current_camera_point += 1
	elif player.position.x < position.x - 429:
		if camera_points.has(current_camera_point - 1):
			current_camera_point -= 1
		
	position.x = camera_points[current_camera_point]
