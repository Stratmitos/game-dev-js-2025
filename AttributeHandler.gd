extends Node

enum {player, enemy}

var strength: RefCounted = preload("res://services/AtrributeHandler/Strength.gd").new()
var intelligence: RefCounted = preload("res://services/AtrributeHandler/Intelligence.gd").new()
var agility: RefCounted = preload("res://services/AtrributeHandler/Agility.gd").new()

func get_knockback_chance(identity: int) -> float:
	return strength.get_value(identity) * 0.20 + intelligence.get_value(identity) * 0.05

func get_dominate_chance(identity: int) -> float:
	var base_chance: float = strength.get_value(identity) * 0.5
	base_chance -= intelligence.get_value(identity) * 0.25 + agility.get_value(identity) * 0.25
	if base_chance < 0.0:
		base_chance = 0.0

	return base_chance

func get_coward_chance(identity: int) -> float:
	var base_chance: float = intelligence.get_value(identity) * 0.5
	base_chance -= strength.get_value(identity) * 0.25 + agility.get_value(identity) * 0.25
	if base_chance < 0.0:
		base_chance = 0.0

	return base_chance

func get_evade_chance(identity: int) -> float:
	return agility.get_value(identity) * 0.20 + intelligence.get_value(identity) * 0.05

func get_reckless_chance(identity: int) -> float:
	var base_chance: float = agility.get_value(identity) * 0.5
	base_chance -= strength.get_value(identity) * 0.25 + intelligence.get_value(identity) * 0.25
	if base_chance < 0.0:
		base_chance = 0.0

	return base_chance
