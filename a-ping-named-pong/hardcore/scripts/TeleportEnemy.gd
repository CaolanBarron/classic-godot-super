extends CharacterBody2D
class_name TeleportEnemy

@export var ball: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const MOVE_SPEED = 150.00
const SPRITE_HEIGHT = 100

var starting_position

func _ready():
	starting_position = position
