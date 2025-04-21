extends Node2D

@onready var ui_node: Panel = $MenuPanel

@onready var economy: Panel = ui_node.get_node("Economy")

@onready var statistic: Panel = ui_node.get_node("StatisticPanel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	$GirlTroop.war_is_over.connect(func(is_win) : _on_war_is_over(is_win))
	$Slime.war_is_over.connect(func(is_win) : _on_war_is_over(is_win))

func start() -> void:
	$GirlTroop.spawn(1052.0, AttributeHandler.player)
	$Slime.spawn(100.0, AttributeHandler.enemy)
	economy.set_day_passed(economy.get_day_passed() + 1)
	statistic.refresh_attribute()
	print("Start over")

func _on_player_recruit_troop(value: int) -> void:
	$GirlTroop.on_player_add_troop(value)

func _on_player_start_war(event) -> void:
	if event is InputEventMouseButton and event.pressed:
		MoneyHandler.toggle_allowed_to_spent_money(false)
		$GirlTroop.move()
		$Slime.move()

func _on_war_is_over(is_win: bool) -> void:
	if is_win:
		$WarResult.win()
	else:
		$WarResult.lose()

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

	$WarResult.hide()
	start()
