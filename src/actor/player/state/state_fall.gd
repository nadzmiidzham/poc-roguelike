class_name StateFall
extends Node


export (float) var wall_slide_gravity_rate := 1.5

onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var animated_sprite: AnimationPlayer = get_node("../../Animation")

var state_machine: StateMachine
var is_wall_sliding := false

# state machine functions
func on_enter() -> void:
	print("State: FALL")
	animated_sprite.play("fall")

func on_exit() -> void:
	is_wall_sliding = false


# state logic
func process(_delta) -> void:
	player.check_flip()

	if is_wall_sliding:
		animated_sprite.play("wall_slide")
	if player.is_on_floor():
		state_machine.change_state(state_idle)

func physics_process(_delta) -> void:
	if player.is_on_wall():
		var gravity = player.gravity / wall_slide_gravity_rate;

		is_wall_sliding = true
		player.velocity.y = min(player.velocity.y + gravity, gravity)

	player.move()
	player.compute_gravity()
	player.compute_velocity()
