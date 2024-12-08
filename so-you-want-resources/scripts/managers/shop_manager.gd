extends Node2D

@onready var option_one: Area2D = $Options/Option1
@onready var option_two: Area2D = $Options/Option2
@onready var option_three: Area2D = $Option3
@onready var exit: Area2D = $Exit

@onready var basic_shop_animation: AnimationPlayer = $BasicShopAnimation
@onready var rare_ability_animation: AnimationPlayer = $RareAbilityAnimation

@onready var upgrade_manager: UpgradeManager = $"../UpgradeManager"
@onready var resource_manager: ResourceManager = $"../ResourceManager"

var option_one_upgrade
var option_two_upgrade
var option_three_upgrade

func _ready():
	option_one.area_entered.connect(_option_one_selected)
	option_two.area_entered.connect(_option_two_selected)
	option_three.area_entered.connect(_option_three_selected)
	exit.area_entered.connect(_exit)
	SignalBus.start_shopping.connect(_start_shop)


func _start_shop():
	set_options()
	basic_shop_animation.play('shop_enter')


func _option_one_selected(area):
	#if resource_manager.resource_amount() >= option_one.cost:
	pass


func _option_two_selected(area):
	pass


func _option_three_selected(area):
	pass


func set_options():
	var options = upgrade_manager.get_upgrades_for_shop()
	
	var option1Label = option_one.find_child('UpgradeName')
	option1Label.text = options[0].display_name
	option_one_upgrade = options[0]
	option_one.find_child('ResourceCost').text = str(options[0].cost)
	
	option_two.find_child('UpgradeName').text = options[1].display_name
	option_two_upgrade = options[1]
	option_two.find_child('ResourceCost').text = str(options[1].cost)
	
	var rare_upgrade = upgrade_manager.get_rare_upgrades_for_shop()
	if rare_upgrade:
		rare_ability_animation.play('rare_ability_entrance')
		option_three.find_child('UpgradeName').text = rare_upgrade.display_name
		option_three_upgrade = rare_upgrade
		option_three.find_child('ResourceCost').text = str(rare_upgrade.cost)
	

func reset_options():
	option_one_upgrade = null
	option_one.find_child('UpgradeName').text = ''
	option_one.find_child('ResourceCost').text = '0'
	option_two_upgrade = null
	option_two.find_child('UpgradeName').text = ''
	option_two.find_child('ResourceCost').text = '0'
	option_three_upgrade = null
	option_three.find_child('UpgradeName').text = ''
	option_three.find_child('ResourceCost').text = '0'


func _exit(area):
	if option_three_upgrade:
		rare_ability_animation.play('rare_ability_exit')
	reset_options()
	basic_shop_animation.play('shop_exit')
	SignalBus.end_shopping.emit()
