extends Node2D

var playerScore = 0
var cpuScore = 0

@onready var playerScoreLabel:Label = %PlayerScore
@onready var cpuScoreLabel:Label = %CPUScore

@onready var playerScoreSound:AudioStreamPlayer = %PlayerScoreSound
@onready var cpuScoreSound:AudioStreamPlayer = %CPUScoreSound

@onready var ball:BasicBall = %Ball

func _ready():
	ball.scorePlayer.connect(player_scored)
	ball.scoreCPU.connect(cpu_scored)


func player_scored():
	playerScore += 1
	playerScoreLabel.text = str(playerScore)
	ball.reset()
	playerScoreSound.play()


func cpu_scored():
	cpuScore += 1
	cpuScoreLabel.text = str(cpuScore)
	ball.reset()
	cpuScoreSound.play()
