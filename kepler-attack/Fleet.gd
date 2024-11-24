extends Node2D
class_name Fleet


var alien_scene = preload("res://objects/alien.tscn")

@export var rows: int
@export var columns: int
@export var spacing: int
func _ready(): 
	instantiate_aliens()

func instantiate_aliens():
	# Thanks youtube man this is probably very easy but i cant think of it right now
	for row in rows:
		var width = spacing * (columns - 1)
		var height = spacing * (rows -1)
		var centering = Vector2(-width/2, -height/2)
		var row_position = Vector2(centering.x, centering.y + (row * spacing))
		for column in columns:
			var alien = alien_scene.instantiate()
			add_child(alien)
			var position = row_position
			position.x += column * spacing
			alien.position = position
		
