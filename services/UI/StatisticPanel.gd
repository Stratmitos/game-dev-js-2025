extends Panel

func _ready() -> void:
	refresh_money()

func refresh_attribute() -> void:
	$STR.text = "STR: %d" % AttributeHandler.strength.get_value(AttributeHandler.player)
	$INT.text = "INT: %d" % AttributeHandler.intelligence.get_value(AttributeHandler.player)
	$AGL.text = "AGL: %d" % AttributeHandler.agility.get_value(AttributeHandler.player)

func refresh_money() -> void:
	$Money.text = "Money: %d" % MoneyHandler.get_value()
