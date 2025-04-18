extends Timer

@onready var parent = get_parent()

func _on_timeout():
	var is_coward_activated: bool = randf_range(0.0, 100.0) <= parent.coward_rate
	var is_dominate_activated: bool = randf_range(0.0, 100.0) <= parent.dominate_rate
	var is_reckless_activated: bool = randf_range(0.0, 100.0) <= parent.reckless_rate

	if is_coward_activated and parent.stacked_count > 0 and parent.coward_rate > 0.0:
		print("coward!")
		parent.on_character_debuff_activated()
	if is_dominate_activated and parent.stacked_count > 0 and parent.dominate_rate > 0.0:
		print("dominated!")
		parent._on_apply_attack_detect_enemy(parent.get_node("Skin/AttackRange"))
	if is_reckless_activated and parent.stacked_count > 0 and parent.reckless_rate > 0.0:
		print("reckelss!")
		parent.on_character_debuff_activated()
