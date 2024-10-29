extends Area2D
class_name Bullet

var speed = 300
var goal = -400

func _process(delta):
	position = position.move_toward(Vector2(goal,0), speed * delta)

func _on_area_entered(area):
	if area.name == 'Player':
		rotation_degrees = 180
		goal = 0
