extends Node2D

signal war_is_over(is_win: bool)

var stacked_count: int = 10
var hp: float = 100.0
var atk: float
var def: float
var knockback_rate: float
var dominate_rate: float
var crit_rate: float
var crit_dmg: float
var evade_rate: float
var coward_rate: float
var mspd: float
var atk_cd: float
var reckless_rate: float
var destination:float
var identity: int

var animation_tree: AnimationTree
var state_machine

func _ready() -> void:
	$StackedIndicator.text = str(stacked_count)
	$DebuffTimer.setup(self)

	var apply_attack: Area2D = get_node("Skin/ApplyAttack")
	if apply_attack.is_inside_tree():
		apply_attack.setup(self)

	var attack_range: Area2D = get_node("Skin/AttackRange")
	if attack_range.is_inside_tree():
		attack_range.setup(self)

	animation_tree = get_node("Skin/AnimationTree")
	if animation_tree.is_inside_tree():
		animation_tree.setup(self)
		state_machine = animation_tree["parameters/playback"]
	else:
		print("Can't running player character, AnimationTree not found!")
		queue_free()

func _process(delta) -> void:
	if MoneyHandler.is_allowed_to_spent_money():
		return

	if state_machine.get_current_node() == "movement":
		if identity == AttributeHandler.player:
			if position.x < 1000:
				position.x += delta * mspd
			else:
				state_machine.travel("idle")
		else:
			if position.x > 100:
				position.x -= delta * mspd
			else:
				state_machine.travel("idle")

func spawn(dest: float, id: int) -> void:
	$DebuffTimer.stop()
	visible = true
	set_process(true)
	identity = id
	destination = dest
	if identity == AttributeHandler.enemy:
		position = Vector2(1052, 100)
		if $Skin.scale.x > 0:
			$Skin.scale.x = -$Skin.scale.x
	else:
		position = Vector2(100, 100)

	AttributeHandler.strength.set_value(id, randi_range(10, 100))
	AttributeHandler.intelligence.set_value(id, randi_range(10, 100))
	AttributeHandler.agility.set_value(id, randi_range(10, 100))
	_init_attribute_point_effect()

	state_machine.travel("idle")

func move() -> void:
	state_machine.travel("movement")

func attack() -> void:
	if is_allowed_to_attack:
		is_allowed_to_attack = false
		state_machine.travel("atk-fe")
		$AttackTimer.wait_time = atk_cd
		$AttackTimer.start()
	else:
		state_machine.travel("idle")

func on_character_receive_damage(value: float, node_source: Node2D) -> bool:
	value -= def
	var evade: bool = randf_range(0.0, 100.0) <= AttributeHandler.get_evade_chance(identity)
	if not evade:
		$DamageIndicator.show_damage(value)
		while value > 0:
			var current_hp: float = hp
			hp -= value
			value -= current_hp
			if hp <= 0:
				stacked_count -= 1
				if stacked_count <= 0:
					state_machine.travel("hit")
					$StackedIndicator.text = str(0)
					if node_source:
						value = 0
						node_source.on_character_kill_enemy()
				else:
					_init_attribute_point_effect()
					$StackedIndicator.text = str(stacked_count)
					hp = 100.0

			await get_tree().create_timer(0.1).timeout
	else:
		$DamageIndicator.show_text("MISS!")

	return not evade

func on_character_debuff_activated() -> void:
	stacked_count -= 1
	if stacked_count <= 0:
		hp = 0
		$StackedIndicator.text = str(0)
		state_machine.travel("hit")
	else:
		$StackedIndicator.text = str(stacked_count)
		_init_attribute_point_effect()

func on_character_dead() -> void:
	$DebuffTimer.stop()
	visible = false
	set_process(false)
	if not MoneyHandler.is_allowed_to_spent_money():
		MoneyHandler.toggle_allowed_to_spent_money(true)
		emit_signal("war_is_over", not identity == AttributeHandler.player)

func on_character_kill_enemy() -> void:
	$DebuffTimer.stop()
	move()

func on_player_add_troop(value: int) -> void:
	stacked_count += value
	$StackedIndicator.text = str(stacked_count)

func _init_attribute_point_effect() -> void:
	atk = AttributeHandler.strength.get_atk_point(identity) * stacked_count
	def = AttributeHandler.strength.get_def_point(identity) * stacked_count
	knockback_rate = AttributeHandler.get_knockback_chance(identity)
	dominate_rate = AttributeHandler.get_dominate_chance(identity)

	crit_rate = AttributeHandler.intelligence.get_critical_rate(identity)
	crit_dmg = AttributeHandler.intelligence.get_critical_damage(identity)
	coward_rate = AttributeHandler.get_coward_chance(identity)

	mspd = 100 + AttributeHandler.agility.get_movement_speed(identity)
	atk_cd = 1.7 - AttributeHandler.agility.get_attack_speed(identity)
	evade_rate = AttributeHandler.get_evade_chance(identity)
	reckless_rate = AttributeHandler.get_reckless_chance(identity)

func _on_attack_timer_timeout():
	is_allowed_to_attack = true
	if not state_machine.get_current_node() == "hit" and not state_machine.get_current_node() == "movement":
		attack()

func _on_indicator_damage_hide():
	if hp <= 0 and stacked_count <= 0:
		on_character_dead()
