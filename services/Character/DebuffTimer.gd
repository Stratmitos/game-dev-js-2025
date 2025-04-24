extends Timer

var parent: Node2D

func setup(_parent: Node2D) -> void:
	parent = _parent

func _on_timeout():
	var is_coward_activated: bool = randf_range(0.0, 100.0) <= parent.coward_rate
	var is_dominate_activated: bool = randf_range(0.0, 100.0) <= parent.dominate_rate
	var is_reckless_activated: bool = randf_range(0.0, 100.0) <= parent.reckless_rate

	if is_coward_activated and parent.stacked_count > 0 and parent.coward_rate > 0.0:
		parent.emit_signal("troop_coward", parent.identity)
		parent.on_character_debuff_activated()
	if is_dominate_activated and parent.stacked_count > 0 and parent.dominate_rate > 0.0:
		parent.emit_signal("troop_dominated", parent.identity)
		parent.on_character_debuff_activated()
	if is_reckless_activated and parent.stacked_count > 0 and parent.reckless_rate > 0.0:
		parent.emit_signal("troop_reckless", parent.identity)
		parent.on_character_debuff_activated()
