extends Upgrade

var display_name = 'Increase Bullet Size'
var cost = 3

func execute():
	upgrade_manager.bullet_size_modifier += 2
