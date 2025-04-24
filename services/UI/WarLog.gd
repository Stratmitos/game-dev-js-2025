extends Panel

const message_str: Array = [
	"%s: Tried a friendly pat on the back... now the friend’s a pancake.\n",
	"%s: Went for a push. Physics went for a kill.\n",
	"%s: Flexed so hard, someone in the group disintegrated.\n",
	"%s: Gave a thumbs up... and crushed a teammate’s shoulder.\n",
	"%s: Went for a high five and caused internal bleeding.\n",
]

const message_int: Array = [
	"%s: Calculated all the odds... and chose to nope out.\n",
	"%s: Retreating is the most logical move. Also the most cowardly.\n",
	"%s: Just solved quantum physics mid-battle, and forgot how to stab.\n",
	"%s: Too much thinking, not enough stabbing.\n",
	"%s: Violence is not the answer. Unfortunately, the opposition disagreed.\n",
]

const message_agl: Array = [
	"%s: Dodged everything... except the ground. RIP.\n",
	"%s: Speed is great—until you trip on a rock and fall into a bear trap.\n",
	"%s: Was a blur. Now they’re a stain.\n",
	"%s: Moved like lightning. Thought like a snail. Fatal combo.\n",
	"%s: Zigged, zagged, and zapped... right off a cliff.\n",
]

func clear() -> void:
	$RichTextLabel.clear()

func append_damage_log(identity: int, damage: int) -> void:
	var victim: String = "Your troop" if identity == AttributeHandler.player else "Enemy troop"
	$RichTextLabel.append_text("%s took %d damage!\n" % [victim, damage])

func append_debuff_log(identity: int, debuf_type: int) -> void:
	var messageid: int = randi_range(0, 4)
	var victim: String = "Your troop" if identity == AttributeHandler.player else "Enemy troop"
	if debuf_type == 0:
		$RichTextLabel.append_text(message_str[messageid] % [victim])
	elif debuf_type == 1:
		$RichTextLabel.append_text(message_int[messageid] % [victim])
	else:
		$RichTextLabel.append_text(message_agl[messageid] % [victim])
