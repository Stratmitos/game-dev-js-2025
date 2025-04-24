extends Node2D

@onready var ui_node: Panel = $MenuPanel

@onready var economy: Panel = ui_node.get_node("Economy")

@onready var statistic: Panel = ui_node.get_node("StatisticPanel")

@onready var recruit: Panel = ui_node.get_node("RecruitPanel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AttributeHandler.strength.set_value(AttributeHandler.player, 10)
	AttributeHandler.intelligence.set_value(AttributeHandler.player, 10)
	AttributeHandler.agility.set_value(AttributeHandler.player, 10)
	$GirlTroop.war_is_over.connect(func(is_win) : _on_war_is_over(is_win))
	$GirlTroop.troop_dominated.connect(func(identity) : _on_debuff_dominated_applied(identity))
	$GirlTroop.troop_coward.connect(func(identity) : _on_debuff_coward_applied(identity))
	$GirlTroop.troop_reckless.connect(func(identity) : _on_debuff_reckless_applied(identity))

	AttributeHandler.strength.set_value(AttributeHandler.enemy, 10)
	AttributeHandler.intelligence.set_value(AttributeHandler.enemy, 10)
	AttributeHandler.agility.set_value(AttributeHandler.enemy, 10)
	$Slime.war_is_over.connect(func(is_win) : _on_war_is_over(is_win))
	$Slime.troop_dominated.connect(func(identity) : _on_debuff_dominated_applied(identity))
	$Slime.troop_coward.connect(func(identity) : _on_debuff_coward_applied(identity))
	$Slime.troop_reckless.connect(func(identity) : _on_debuff_reckless_applied(identity))

	start()
	statistic.refresh_attribute()

func start() -> void:
	$WarResult.hide()
	statistic.refresh_attribute()
	recruit.refresh_attribute()

	$GirlTroop.spawn(1052.0, AttributeHandler.player)

	if economy.get_day_passed() > 0:
		var prev_str: int = AttributeHandler.strength.get_value(AttributeHandler.enemy)
		var prev_int: int = AttributeHandler.intelligence.get_value(AttributeHandler.enemy)
		var prev_agl: int = AttributeHandler.agility.get_value(AttributeHandler.enemy)
		AttributeHandler.strength.set_value(AttributeHandler.enemy, prev_str + randi_range(3, 6) * economy.get_day_passed())
		AttributeHandler.intelligence.set_value(AttributeHandler.enemy, prev_int + randi_range(3, 6) * economy.get_day_passed())
		AttributeHandler.agility.set_value(AttributeHandler.enemy, prev_agl + randi_range(3, 6) * economy.get_day_passed())

	$Slime.spawn(100.0, AttributeHandler.enemy)
	$Slime.on_player_add_troop(randi_range(5, 10) * economy.get_day_passed())

func _on_player_recruit_troop(value: int) -> void:
	$GirlTroop.on_player_add_troop(value)

func _on_player_start_war(event) -> void:
	if event is InputEventMouseButton and event.pressed:
		MoneyHandler.toggle_allowed_to_spent_money(false)
		$GirlTroop.move()
		$Slime.move()
		_toggle_war_log(true)

func _on_war_is_over(is_win: bool) -> void:
	if is_win:
		$WarResult.win()
	else:
		$WarResult.lose()

	_toggle_war_log(false)

func _on_debuff_dominated_applied(identity: int) -> void:
	$WarLog.append_debuff_log(identity, 0)

func _on_debuff_coward_applied(identity: int) -> void:
	$WarLog.append_debuff_log(identity, 1)

func _on_debuff_reckless_applied(identity: int) -> void:
	$WarLog.append_debuff_log(identity, 2)

func _on_war_result_finished() -> void:
	var current_public_trust: int = economy.get_public_trust()
	if $WarResult.is_win:
		current_public_trust += 25 + economy.get_day_passed()
		if current_public_trust > 100:
			current_public_trust = 100
	else:
		current_public_trust -= 10 + economy.get_day_passed()
		if current_public_trust < 0:
			current_public_trust = 0
	economy.set_public_trust(current_public_trust)

	var current_tax: int = economy.get_base_tax() + (current_public_trust - economy.get_base_tax())
	economy.set_tax_earned(current_tax)
	economy.set_base_tax(current_tax)
	MoneyHandler.set_value(MoneyHandler.get_value() + current_tax)

	economy.set_day_passed(economy.get_day_passed() + 1)
	start()

func _toggle_war_log(value: bool) -> void:
	$WarLog.clear()
	$WarLog.visible = value
	ui_node.visible = not value
