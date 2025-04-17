var agility: Array = [0, 0]

func set_value(id: int, value: int) -> void:
	agility[id] = value

func get_value(id: int) -> int:
	return agility[id]

func get_movement_speed(id: int) -> float:
	return agility[id] * 0.0075

func get_attack_speed(id: int) -> float:
	return agility[id] * 0.001
