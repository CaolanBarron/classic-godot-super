extends Area2D


const SPEED = 200.0
# Value determines how close the paddle can be to random Y or ball 
const MOVEBUFFER = 5
@onready var _screen_size_y = get_viewport_rect().size.y
@onready var ball: Ball = %Ball

enum CPUState {DEFENSE, ROAM}

var currentState: CPUState = CPUState.ROAM
var randomY = 0.00

func _physics_process(delta):
	# If the ball is heading towards the paddle defend, else roam
	if ball.position.x > ball.previousXPos:
		currentState = CPUState.DEFENSE
	else:
		currentState = CPUState.ROAM
	
	if currentState == CPUState.DEFENSE:
		_defend(delta)
	else:
		_roam(delta)

func _defend(delta):
	var ballDistanceCheck
	if ball.position.y > position.y:
		ballDistanceCheck = ball.position.y - position.y
	else:
		ballDistanceCheck = position.y - ball.position.y
	
	if ballDistanceCheck < MOVEBUFFER: return
	
	if ball.position.y > position.y:
			position.y = clamp(position.y + 1 * SPEED * delta, -215, _screen_size_y / 2 - 50)
	# If the ball is below the paddle move downwards
	else:
			position.y = clamp(position.y + -1 * SPEED * delta, -215, _screen_size_y / 2 - 50)

func _roam(delta):
	# check distance from randomY, If its below the MOVE BUFFER choose a new randomY
	var randomYDistanceCheck
	if randomY > position.y:
		randomYDistanceCheck = randomY - position.y
	else:
		randomYDistanceCheck = position.y - randomY
	
	if randomYDistanceCheck > MOVEBUFFER:
		# If its not move towards the random Y
		position.y = move_toward(position.y, randomY, SPEED * delta)
	else:
		# pick a random spot within the screen height
		randomY = RandomNumberGenerator.new().randf_range(-_screen_size_y/2, _screen_size_y/2)
	
func _on_area_entered(area):
	if area.name == 'Ball':
		area.direction = area.direction * Vector2.LEFT
		area.direction.y = RandomNumberGenerator.new().randf_range(-1.00, 1.00)
		area.speed_increment()
	
