var strength: Array = [0, 0]

func set_value(id: int, value: int) -> void:
	strength[id] = value

func get_value(id: int) -> int:
	return strength[id]

func get_atk_point(id: int) -> float:
	return strength[id] * 0.7

func get_def_point(id: int) -> float:
	return strength[id] * 0.5
