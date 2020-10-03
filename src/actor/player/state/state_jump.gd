class_name StateJump
extends Node

var state_machine: StateMachine
var _is_jump_finished: bool

onready var player := get_node("../../")
onready var state_fall := get_node("../Fall")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

# state machine functions
func on_enter():
	print("State: JUMP")
	_is_jump_finished = false
	animatedSprite.play("jump")

func on_exit():
	pass


# state logic
func process(delta):
	if _is_jump_finished:
		state_machine.change_state(state_fall)

func physics_process(delta):
	if player.is_on_floor():
		player.velocity.y = -player.jump_force
	if player.velocity.y > 0:
		_is_jump_finished = true

	if Input.is_action_pressed("move_right"):
		player.velocity = Vector2(player.speed, player.velocity.y)
	elif Input.is_action_pressed("move_left"):
		player.velocity = Vector2(-player.speed, player.velocity.y)
	else:
		player.velocity = Vector2(0, player.velocity.y)

	player.compute_gravity()
	player.compute_velocity()
