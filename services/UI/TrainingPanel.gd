extends Panel

var playerid: int = AttributeHandler.player

var price_str: int = 10

var price_int: int = 10

var price_agl: int = 10

func _ready() -> void:
	refresh_training_price()

func refresh_training_price() -> void:
	var node_economy = get_parent().get_node("Economy")
	$STR.text = "Train STR: (%d)" % (price_str + node_economy.get_day_passed() + (100 - node_economy.get_public_trust()))
	$INT.text = "Train INT: (%d)" % (price_int + node_economy.get_day_passed() + (100 - node_economy.get_public_trust()))
	$AGL.text = "Train AGL: (%d)" % (price_agl + node_economy.get_day_passed() + (100 - node_economy.get_public_trust()))

func _on_training_str(event):
	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_str):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_str)
			var str_val: int = AttributeHandler.strength.get_value(playerid) + randi_range(1, 5)
			var node_statistic: Panel = get_parent().get_node("StatisticPanel")
			AttributeHandler.strength.set_value(playerid, str_val)
			_refresh_statistic()

func _on_training_int(event):
	var current_money = MoneyHandler.get_value()
	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_int):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_int)
			var str_val: int = AttributeHandler.intelligence.get_value(playerid) + randi_range(1, 5)
			AttributeHandler.intelligence.set_value(playerid, str_val)
			_refresh_statistic()

func _on_training_agility(event):
	var current_money = MoneyHandler.get_value()
	if event is InputEventMouseButton and event.pressed:
		if MoneyHandler.is_value_enough_for(price_agl):
			MoneyHandler.set_value(MoneyHandler.get_value() - price_agl)
			var str_val: int = AttributeHandler.agility.get_value(playerid) + randi_range(1, 5)
			AttributeHandler.agility.set_value(playerid, str_val)
			_refresh_statistic()

func _refresh_statistic() -> void:
	var node_statistic: Panel = get_parent().get_node("StatisticPanel")
	node_statistic.refresh_attribute()
	node_statistic.refresh_money()
