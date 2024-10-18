extends Node2D

var playerScore : int = 0
var enemyScore  : int  = 0

func playerScored():
	playerScore += 1
	print('Player scored')


func enemyScored():
	enemyScore += 1
	print('Enemy scored')
