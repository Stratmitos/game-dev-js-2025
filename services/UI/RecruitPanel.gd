extends Panel

@onready var playerid: int = AttributeHandler.player

signal on_player_recruit_troop(value: int)

var str_val: int

var agl_val: int

var int_val: int

var price_recruit: int = 20

var price_refresh_recruit: int = 5

func _ready() -> void:
	refresh_attribute()
	refresh_recruit_price()
	refresh_find_other_candidate_price()

func refresh_recruit_price() -> void:
	$Price.text = "Price: %d" % price_recruit

func refresh_find_other_candidate_price() -> void:
	$Find.text = "Find other candidate (%d)" % price_refresh_recruit

func refresh_attribute() -> void:
	str_val = randi_range(1, 5)
	agl_val = randi_range(1, 5)
	int_val = randi_range(1, 5)
	$STR.text = "STR: %d" % str_val
	$AGL.text = "AGL: %d" % agl_val
	$INT.text = "INT: %d" % int_val

func _on_find_other_candidate(event) -> void:
	if not MoneyHandler.is_allowed_to_spent_money():
		return

	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_refresh_recruit):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_refresh_recruit)
			refresh_attribute()
			get_parent().get_node("StatisticPanel").refresh_money()

func _on_add_one(event):
	if not MoneyHandler.is_allowed_to_spent_money():
		return

	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_recruit * 1):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_recruit * 1)
			_apply_additional_attribute(1)
			emit_signal("on_player_recruit_troop", 1)
			get_parent().get_node("StatisticPanel").refresh_money()

func _on_add_five(event):
	if not MoneyHandler.is_allowed_to_spent_money():
		return

	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_recruit * 5):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_recruit * 5)
			_apply_additional_attribute(5)
			emit_signal("on_player_recruit_troop", 5)
			get_parent().get_node("StatisticPanel").refresh_money()

func _on_add_fifteen(event):
	if not MoneyHandler.is_allowed_to_spent_money():
		return

	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_recruit * 15):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_recruit * 15)
			_apply_additional_attribute(15)
			emit_signal("on_player_recruit_troop", 15)
			get_parent().get_node("StatisticPanel").refresh_money()

func _on_add_twenty_five(event):
	if not MoneyHandler.is_allowed_to_spent_money():
		return

	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_recruit * 25):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_recruit * 25)
			_apply_additional_attribute(25)
			emit_signal("on_player_recruit_troop", 25)
			get_parent().get_node("StatisticPanel").refresh_money()

func _apply_additional_attribute(multiplier: int):
	var current_str: int = AttributeHandler.strength.get_value(playerid)
	var current_int: int = AttributeHandler.intelligence.get_value(playerid)
	var current_agl: int = AttributeHandler.agility.get_value(playerid)
	AttributeHandler.strength.set_value(playerid, current_str + str_val * multiplier)
	AttributeHandler.intelligence.set_value(playerid, current_int + int_val * multiplier)
	AttributeHandler.agility.set_value(playerid, current_agl + agl_val * multiplier)
	get_parent().get_node("StatisticPanel").refresh_attribute()
