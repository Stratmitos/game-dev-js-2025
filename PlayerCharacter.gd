extends Node2D

var mspd: float = 100
var max_attack_cooldown: float = 2.0
var min_attack_cooldown: float = 1.3

@onready var state_machine = $AnimationTree["parameters/playback"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if state_machine.get_current_node() == "movement":
		if position.x >= 1000.0:
			attack()
		else:
			position.x += delta * mspd
			state_machine.travel("movement")

func spawn(_mspd: float = 100) -> void:
	state_machine.travel("idle")
	move()

func move() -> void:
	state_machine.travel("movement")

func attack() -> void:
	state_machine.travel("atk-fe")
	$AttackTimer.wait_time = randf_range(min_attack_cooldown, max_attack_cooldown)
	$AttackTimer.start()

func _on_animation_tree_animation_finished(_anim_name):
	pass

func _on_attack_timer_timeout():
	attack()
