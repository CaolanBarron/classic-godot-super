extends Node2D
class_name UpgradeManager

var basic_upgrades :Array 
var rare_upgrades :Array
var runtime_rare_upgrades

var used_rare_upgrades = []

@onready var player: Player = $"../Player"

var bullet_size_modifier: float = 0.0
var bullet_fire_rate_modifier: float = 0.0
var player_speed_modifier: float = 0.0

func _ready():
	basic_upgrades = [
		preload("res://objects/upgrades/fire_faster.tscn"),
		preload("res://objects/upgrades/increase_bullet_size.tscn")
	]
	rare_upgrades = [
		preload("res://objects/upgrades/side_dash.tscn")
	]
	runtime_rare_upgrades = rare_upgrades

func reset_modifiers():
	bullet_size_modifier = 0.0
	bullet_fire_rate_modifier = 0.0
	player_speed_modifier = 0.0


func _input(event:InputEvent):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			var instance = basic_upgrades[0].instantiate()
			player.add_upgrade(instance)
		if event.keycode == KEY_Y:
			var instance = basic_upgrades[1].instantiate()
			player.add_upgrade(instance)


func  get_upgrades_for_shop():
	var option_one = basic_upgrades.pick_random()
	var option_two = basic_upgrades.pick_random()
	while option_one == option_two:
		option_two = basic_upgrades.pick_random()
	
	return [option_one.instantiate(), option_two.instantiate()]

func get_rare_upgrades_for_shop():
	var rare_upgrade = runtime_rare_upgrades.pick_random()
	return rare_upgrade.instantiate()


func erase_rare_upgrade(upgrade):
	runtime_rare_upgrades.erase(upgrade)
