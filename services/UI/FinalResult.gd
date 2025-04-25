extends Panel

func showup(text_val: String) -> void:
	visible = true
	$Label.text = text_val + "\nPress Enter / Space to back to main menu"

func _input(event) -> void:
	if event.is_pressed() and InputMap.event_is_action(event, "ui_accept") and visible:
		SceneManager.goto_scene("uid://dcpwpugdsfu81")
