extends Node

@onready var money: int = 100

func set_value(value: int) -> void:
	money = value

func get_value() -> int:
	return money

func is_value_enough_for(price: int) -> bool:
	return money >= price
