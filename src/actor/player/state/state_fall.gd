class_name StateFall
extends Node


onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

var state_machine: StateMachine

# state machine functions
func on_enter() -> void:
	print("State: FALL")
	animatedSprite.play("fall")

func on_exit() -> void:
	pass


# state logic
func process(_delta) -> void:
	if player.is_on_floor():
		state_machine.change_state(state_idle)

	# flip sprite
	if !player.is_facing_right && Input.is_action_pressed("move_right"):
		player.flip()
	if player.is_facing_right && Input.is_action_pressed("move_left"):
		player.flip()

func physics_process(_delta) -> void:
	player.move()
	player.compute_gravity()
	player.compute_velocity()
