extends Label

func _ready():
	SignalBus.increase_score.connect(_increase_score)
	SignalBus.reset_score.connect(_reset_score)
	SignalBus.bullet_missed.connect(_bullet_missed_score)

func _increase_score():
	var current_score = int(text)
	text = str(current_score + 100)


func _reset_score():
	text = '000'

func _bullet_missed_score():
	var current_score = int(text)
	text = str(current_score - 50)
