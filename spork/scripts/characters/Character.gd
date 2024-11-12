extends GameObject
class_name Character

func get_inventory() -> Array[Item]:
	return get_children() as Array[Item]
