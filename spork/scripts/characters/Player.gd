extends Character
class_name Player

func find_surrounding_objects():
	var siblings:Array = get_parent().get_children()
	return siblings.filter(func(o): return o.name != 'Player')
