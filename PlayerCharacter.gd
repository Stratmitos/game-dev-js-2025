extends Node2D

var mspd: float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	position.x += delta * mspd

func spawn(mspd: float = 100) -> void:
	pass
