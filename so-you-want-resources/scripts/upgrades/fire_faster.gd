extends Upgrade

var display_name = 'Increase Fire Rate'
var cost = 3

func execute():
	upgrade_manager.bullet_fire_rate_modifier += -0.25
