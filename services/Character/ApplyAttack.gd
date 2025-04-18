extends Area2D

var parent: Node2D

func setup(_parent: Node2D) -> void:
	parent = _parent

func _on_enemy_entered(area):
	var total_damage = parent.atk
	var critical: bool = randf_range(0.0, 100.0) <= parent.crit_rate
	if critical:
		total_damage += parent.atk * (parent.crit_dmg / 100)

	var is_hit: bool = await area.get_parent().get_parent().on_character_receive_damage(total_damage, parent)
	if parent.knockback_rate > 0.0 and is_hit:
		var knocked: bool = randf_range(0.0, 100) <= parent.knockback_rate
		if knocked:
			area.get_parent().get_parent().state_machine.travel("hit")
			if parent.identity == AttributeHandler.player:
				area.get_parent().get_parent().position.x += 25.0
			else:
				area.get_parent().get_parent().position.x -= 25.0
