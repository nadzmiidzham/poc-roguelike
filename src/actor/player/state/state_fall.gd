class_name StateFall
extends Node


onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

var state_machine: StateMachine

# state machine functions
func on_enter():
	print("State: FALL")
	animatedSprite.play("fall")

func on_exit():
	pass


# state logic
func process(delta):
	if player.is_on_floor():
		state_machine.change_state(state_idle)

	# flip sprite
	if !player.is_facing_right && Input.is_action_pressed("move_right"):
		player.flip()
	if player.is_facing_right && Input.is_action_pressed("move_left"):
		player.flip()

func physics_process(delta):
	if Input.is_action_pressed("move_right"):
		player.velocity = Vector2(player.speed, player.velocity.y)
	elif Input.is_action_pressed("move_left"):
		player.velocity = Vector2(-player.speed, player.velocity.y)
	else:
		player.velocity = Vector2(0, player.velocity.y)

	player.compute_gravity()
	player.compute_velocity()
