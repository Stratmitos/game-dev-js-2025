extends Node2D

var stacked_count: int = randi_range(1, 5)
var hp: float = 100.0
var atk: float
var def: float
var dominate_rate: float
var crit_rate: float
var crit_dmg: float
var coward_rate: float
var mspd: float
var atk_cd: float
var reckless_rate: float
var destination:float
var identity: int

@onready var state_machine = $AnimationTree["parameters/playback"]

func _ready() -> void:
	$StackedIndicator.text = str(stacked_count)

func _process(delta) -> void:
	if state_machine.get_current_node() == "movement":
		if identity == AttributeHandler.player:
			if position.x <= 1000:
				position.x += delta * mspd
			else:
				state_machine.travel("idle")
		else:
			if position.x >= 250:
				position.x -= delta * mspd
			else:
				state_machine.travel("idle")

func spawn(dest: float, id: int) -> void:
	identity = id
	destination = dest
	if destination < 250:
		$Skin.scale.x = -$Skin.scale.x
	
	AttributeHandler.strength.set_value(id, randi_range(10, 100))
	AttributeHandler.intelligence.set_value(id, randi_range(10, 100))
	AttributeHandler.agility.set_value(id, randi_range(10, 100))
	_init_attribute_point_effect()

	state_machine.travel("idle")
	move()

func move() -> void:
	state_machine.travel("movement")

func attack() -> void:
	state_machine.travel("atk-fe")
	$AttackTimer.wait_time = atk_cd
	$AttackTimer.start()

func on_character_receive_damage(value: float, node_source: Node2D) -> void:
	$DamageIndicator.show_damage(value)
	while value > 0:
		var current_hp: float = hp
		hp -= value
		value -= current_hp
		if hp <= 0:
			stacked_count -= 1
			if stacked_count <= 0:
				$StackedIndicator.text = str(0)
				node_source.on_character_kill_enemy()
			else:
				$StackedIndicator.text = str(stacked_count)
				hp = 100.0

		await get_tree().create_timer(0.1).timeout

func on_character_kill_enemy() -> void:
	$AttackTimer.stop()
	move()

func _init_attribute_point_effect() -> void:
	atk = AttributeHandler.strength.get_atk_point(identity) * stacked_count
	def = AttributeHandler.strength.get_def_point(identity) * stacked_count
	dominate_rate = AttributeHandler.get_dominate_chance(identity)

	crit_rate = AttributeHandler.intelligence.get_critical_rate(identity)
	crit_dmg = AttributeHandler.intelligence.get_critical_damage(identity)
	coward_rate = AttributeHandler.get_coward_chance(identity)

	mspd = 100 + AttributeHandler.agility.get_movement_speed(identity)
	atk_cd = 1.7 - AttributeHandler.agility.get_attack_speed(identity)
	reckless_rate = AttributeHandler.get_reckless_chance(identity)

func _on_animation_tree_animation_finished(anim_name):
	if hp <= 0 and stacked_count <= 0 and anim_name == "hit":
		queue_free()

func _on_attack_timer_timeout():
	attack()

func _on_attack_range_detect_enemy(_area):
	attack()

func _on_apply_attack_detect_enemy(area):
	area.get_parent().get_parent().on_character_receive_damage(atk, self)

func _on_indicator_damage_hide():
	if hp <= 0:
		queue_free()
