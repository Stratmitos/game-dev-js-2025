extends AnimationTree

var parent: Node2D

func setup(_parent: Node2D) -> void:
	parent = _parent

func _on_animation_finished(anim_name):
	if anim_name == "hit":
		if parent.hp <= 0 and parent.stacked_count <= 0 and parent.visible:
			parent.on_character_dead()
