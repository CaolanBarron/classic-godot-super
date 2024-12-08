extends Node2D
class_name ResourceManager

var resource_scene = preload("res://objects/resource_usable.tscn")

func insert_resource(pos):
	var resource_instance = resource_scene.instantiate()
	resource_instance.position = pos
	call_deferred("add_child", resource_instance)


func resource_amount() -> int:
	return get_child_count()


func get_resources() -> Array:
	return get_children()
