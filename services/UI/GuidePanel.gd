extends Panel

func show_how_to_play() -> void:
	show()
	$RichTextLabel.clear()
	$RichTextLabel.append_text("Objective:\nDefeat slimes for the next 10 days. Each day, you'll face slimes with different numbers and attributes.\n\n")
	$RichTextLabel.append_text("Attribute:\n")
	$RichTextLabel.append_text("Strength: Increases damage, defense, knockback resistance, and the ability to dominate friendly troops.\n")
	$RichTextLabel.append_text("Intelligence: Increases critical rate & critical damage, as well as cowardice rate.\n")
	$RichTextLabel.append_text("Agility: Increases movement and attack speed, evasion rate, and recklessness.\n\n")
	$RichTextLabel.append_text("Other:\n")
	$RichTextLabel.append_text("Winning a round increases public trust and earns you some loot money.\n")
	$RichTextLabel.append_text("Losing a round decreases public trust. The game ends before the 10th day if you run out of money.\n")
	$RichTextLabel.append_text("The higher the public trust, the more people are willing to pay taxes.\n")

func _input(event) -> void:
	if event.is_pressed() and InputMap.event_is_action(event, "ui_cancel") and visible:
		hide()
