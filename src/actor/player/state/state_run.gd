class_name StateRun
extends Node

var state_machine: StateMachine

onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var state_fall := get_node("../Fall")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

# state machine functions
func on_enter():
	print("State: RUN")
	animatedSprite.play("run")

func on_exit():
	pass


# state logic
func process(delta):
	# flip sprite
	if !player.is_facing_right && Input.is_action_pressed("ui_right"):
		player.flip()
	if player.is_facing_right && Input.is_action_pressed("ui_left"):
		player.flip()

func physics_process(delta):
	if (player.velocity.x == 0) && !(Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		state_machine.change_state(state_idle)
	if !player.is_on_floor():
		state_machine.change_state(state_fall)

	if Input.is_action_pressed("ui_right"):
		player.velocity = Vector2(player.speed, player.velocity.y)
	elif Input.is_action_pressed("ui_left"):
		player.velocity = Vector2(-player.speed, player.velocity.y)
	else:
		player.velocity = Vector2(0, player.velocity.y)

	player.compute_gravity()
	player.compute_velocity()
