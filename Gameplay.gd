extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$GirlTroop.spawn(1052.0, AttributeHandler.player)
	$Slime.spawn(100.0, AttributeHandler.enemy)
	$MenuPanel/StatisticPanel.refresh_attribute()

func _on_player_recruit_troop(value: int) -> void:
	$GirlTroop.on_player_add_troop(value)

func _on_player_start_war(event):
	if event is InputEventMouseButton and event.pressed:
		$GirlTroop.move()
		$Slime.move()
