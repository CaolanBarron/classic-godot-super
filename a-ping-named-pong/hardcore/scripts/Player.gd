extends CharacterBody2D
class_name Player

const MOVE_SPEED = 300.0
var transition_input_locked: bool = true
var starting_position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var enemy_will_malfunction:= false

func _ready():
	starting_position = position
	SignalBus.malfunction_teleportation.connect(_enemy_malfunctioned)

func _enemy_malfunctioned():
	enemy_will_malfunction = true
	

func collision_detected(area: Area2D):
	if area.name == 'RightWall':
		call_deferred("change_to_level_one")


func change_to_level_one():
	get_tree().change_scene_to_file("res://hardcore/levels/Level1.tscn")


func _process(_delta):
	if position.x > 3250:
		starting_position = Vector2(3100, 123)
		SignalBus.start_black_hole.emit()
		SignalBus.start_dialogue.emit()
