extends Node

var state_machine: StateMachine

onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var state_fall := get_node("../Fall")
onready var animatedSprite: AnimatedSprite = get_node("../../AnimatedSprite")

# state machine functions
func on_enter():
	print("State: RUN")
	animatedSprite.play("run")

func on_exit():
	pass


# state logic
func process(delta):
	if (player.get_velocity() == Vector2.ZERO):
		state_machine.change_state(state_idle)
	if !player.is_on_floor():
		state_machine.change_state(state_fall)

	# flip sprite
	if !player.is_facing_right && Input.is_action_pressed("ui_right"):
		player.flip()
	if player.is_facing_right && Input.is_action_pressed("ui_left"):
		player.flip()

func physics_process(delta):
	var player_velocity = player.get_velocity()
	var player_speed = player.get_speed()

	if Input.is_action_pressed("ui_right"):
		player.set_velocity(Vector2(player.get_speed(), player_velocity.y))
	elif Input.is_action_pressed("ui_left"):
		player.set_velocity(Vector2(-player.get_speed(), player_velocity.y))
	else:
		player.set_velocity(Vector2(0, player_velocity.y))

	player.compute_gravity()
	player.compute_velocity()
