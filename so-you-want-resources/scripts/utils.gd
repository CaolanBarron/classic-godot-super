extends Node2D


func wrap_object_outside_screen(input: Vector2) -> Vector2:
	var vector:Vector2 = Vector2(input)
	if input.x > get_viewport_rect().size.x / 2:
		vector.x = -get_viewport_rect().size.x / 2
	elif input.x < -get_viewport_rect().size.x / 2:
		vector.x = get_viewport_rect().size.x / 2
	
	if input.y > get_viewport_rect().size.y / 2:
		vector.y = -get_viewport_rect().size.y / 2
	elif input.y < -get_viewport_rect().size.y / 2:
		vector.y = get_viewport_rect().size.y / 2
	
	return vector

func is_outside_screen(input: Vector2, buffer:int = 0) -> bool:
		if input.x - buffer > get_viewport_rect().size.x / 2 or\
		input.x + buffer < -get_viewport_rect().size.x / 2 or\
		input.y - buffer >  get_viewport_rect().size.y / 2 or\
		input.y + buffer < -get_viewport_rect().size.y / 2:
			return true
		return false
