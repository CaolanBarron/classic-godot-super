@tool
extends Node2D

@export var radius = 10.00

func _ready():
	# set the radius of the balls collision shape 2d to the display radius
	var collisionShape = get_node("../CollisionShape2D")
	collisionShape.shape.set_radius(radius)


func _draw():
	draw_circle(Vector2(0,0), radius, Color.WHITE)

