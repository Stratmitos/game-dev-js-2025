extends Label

@onready var is_win: bool

func win() -> void:
	visible = true
	$Timer.start(2.4)
	text = "You Win!"
	is_win = true

func lose() -> void:
	visible = true
	$Timer.start(2.4)
	text = "You Lose!"
	is_win = false
