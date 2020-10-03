class_name StateRun
extends Node

var state_machine: StateMachine

onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var state_jump := get_node("../Jump")
onready var state_fall := get_node("../Fall")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

# state machine functions
func on_enter() -> void:
	print("State: RUN")
	animatedSprite.play("run")

func on_exit() -> void:
	pass


# state logic
func process(delta) -> void:
	# flip sprite
	if !player.is_facing_right && Input.is_action_pressed("move_right"):
		player.flip()
	if player.is_facing_right && Input.is_action_pressed("move_left"):
		player.flip()

func physics_process(delta) -> void:
	if (player.velocity.x == 0) && !(Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
		state_machine.change_state(state_idle)
	if !player.is_on_floor():
		state_machine.change_state(state_fall)
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(state_jump)

	player.move()
	player.compute_gravity()
	player.compute_velocity()
