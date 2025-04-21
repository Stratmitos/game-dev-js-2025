extends Area2D

var parent: Node2D

func setup(_parent: Node2D) -> void:
	parent = _parent

func _on_enemy_detected(_area) -> void:
	parent.attack()

func _on_enemy_leave_attack_range(_area):
	if not _area.name == "ApplyAttack":
		parent.move()
