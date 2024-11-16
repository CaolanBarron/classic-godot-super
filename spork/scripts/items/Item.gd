extends GameObject
class_name Item

@export var can_pick_up : bool = false
@export var can_open : bool = false
@export var is_open : bool = false
@export var can_lock: bool = false
@export var is_locked: bool = false


func _applicable_verbs(word):
	pass
