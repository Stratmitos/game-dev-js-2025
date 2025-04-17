extends Label

const default_pos: Vector2 = Vector2(-20, -50)

signal on_indicator_damage_hide

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and position.y - default_pos.y > -100:
		position.y -= delta * 200

func show_damage(value: int) -> void:
	text = str(value)
	position = Vector2(-20, -50)
	visible = true
	if not $TimerHide.get_time_left() == 0:
		$TimerHide.stop()

	$TimerHide.start()

func _on_timer_hide_timeout():
	visible = false
	position = Vector2(-20, -50)
	emit_signal("on_indicator_damage_hide")
