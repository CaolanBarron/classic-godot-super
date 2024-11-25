extends Area2D
class_name PlayerBullet

var speed = 250

func _ready():
	area_entered.connect(collision_detected)

func _physics_process(delta):
	position.y -= speed * delta
	if position.y < -(get_viewport_rect().size.y / 2):
		queue_free()
		SignalBus.bullet_missed.emit()

func collision_detected(area):
	if area is Alien:
		area.destroy()
		queue_free()
