extends State
class_name EnemyTeleport

const BUFFER_DISTANCE = 5.00
var detected_intersection = null
@onready var _screen_size_y = enemy.get_viewport_rect().size.y
@export var enemy: TeleportEnemy

func Process(_delta):
	if enemy.ball.position.x < enemy.ball.previous_x_pos:
		Transitioned.emit(self, 'Idle')


func Physics_process(_delta):
	var point = detected_intersection
	if !detected_intersection:
		point = find_ball_intersection()
		detected_intersection = point
		if point is Vector2:
			calculate_animation_speed(enemy.ball.velocity,enemy.position.x - enemy.ball.position.x)
			enemy.sprite.play('teleport_leave')


func Enter():
	detected_intersection = null


func Exit():
	detected_intersection = null


func find_ball_intersection():	
	var start_point = enemy.ball.global_position
	var i = 0
	var step_distance = 10  # You can adjust this value to space points properly
	var point = start_point
	if enemy.ball.velocity == Vector2.ZERO: return
	while true:
		i += 1
		if i > 100: break
		# Calculate the next point based on ball's velocity and step distance
		point += enemy.ball.velocity.normalized() * step_distance
		# Break conditions
		if abs(point.y) > _screen_size_y / 2:
			break
		if point.x > enemy.position.x:  # Use tolerance for comparison
			return point


func calculate_animation_speed(ball_speed:Vector2, ball_distance):
	const scale = 80
	var output = ball_speed.length() / ball_distance * scale + 1
	enemy.sprite.speed_scale = output


@warning_ignore("integer_division")
func teleport_enemy(point):
	var half_texture_height = enemy.SPRITE_HEIGHT / 2
	var min_height =-_screen_size_y/2 + half_texture_height
	var max_height =  _screen_size_y/2 - half_texture_height
	enemy.position.y = clamp(point.y, min_height, max_height) 


func collision_detected(area):
	if area.get_parent().name == 'Ball':
		detected_intersection = null


func parent_animation_finished():
	if enemy.sprite.animation == 'teleport_leave':
		if detected_intersection:
			teleport_enemy(detected_intersection)
		enemy.sprite.play('teleport_enter')
