extends Control

func _on_start_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		SceneManager.goto_scene("uid://dpea6t40h1wiw")

func _on_how_to_play_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$GuidePanel.show_how_to_play()
