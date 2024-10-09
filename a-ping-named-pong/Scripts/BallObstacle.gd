extends Area2D

func _on_area_entered(area):
	if area.name == 'Ball':
		# Invert the balls Y direction
		area.direction.y = area.direction.y * -1
