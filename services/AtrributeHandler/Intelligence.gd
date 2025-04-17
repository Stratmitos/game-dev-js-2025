var intelligence: Array = [0, 0]

func set_value(id: int, value: int) -> void:
	intelligence[id] = value

func get_value(id: int) -> int:
	return intelligence[id]

func get_critical_rate(id: int) -> float:
	return intelligence[id] * 0.35

func get_critical_damage(id: int) -> float:
	return intelligence[id] * 0.25
