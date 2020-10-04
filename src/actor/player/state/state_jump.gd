class_name StateJump
extends Node

var state_machine: StateMachine
var _is_jump_finished: bool

onready var player := get_node("../../")
onready var state_fall := get_node("../Fall")
onready var animated_sprite: AnimationPlayer = get_node("../../Animation")

# state machine functions
func on_enter() -> void:
	print("State: JUMP")
	_is_jump_finished = false
	animated_sprite.play("jump")

func on_exit() -> void:
	pass


# state logic
func process(_delta) -> void:
	player.check_flip()
	if _is_jump_finished:
		state_machine.change_state(state_fall)

func physics_process(_delta) -> void:
	if player.is_on_floor():
		player.velocity.y = -player.jump_force
	if player.velocity.y > 0:
		_is_jump_finished = true

	player.move()
	player.compute_gravity()
	player.compute_velocity()
