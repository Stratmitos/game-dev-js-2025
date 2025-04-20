extends Node

@onready var money: int = 100

@onready var allow_to_spent_money: bool = true

func set_value(value: int) -> void:
	money = value

func get_value() -> int:
	return money

func is_value_enough_for(price: int) -> bool:
	return money >= price
func is_allowed_to_spent_money() -> bool:
	return allow_to_spent_money
