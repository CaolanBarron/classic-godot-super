extends AnimationPlayer

@onready var animated_sprite: AnimatedSprite2D = $BlackHole

func _ready():
	SignalBus.start_black_hole.connect(start_animation)


func start_animation():
	current_animation = 'BlackHole'


func black_hole_intro():
	animated_sprite.play("intro")


func black_hole_regular():
	animated_sprite.play("regular")

func end_level():
	get_tree().change_scene_to_file("res://hardcore/levels/End.tscn")
