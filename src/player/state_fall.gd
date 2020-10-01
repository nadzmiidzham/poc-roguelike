extends Node


onready var player := get_node("../../")
onready var animatedSprite: AnimatedSprite = get_node("../../AnimatedSprite")

var state_machine: StateMachine


# state machine functions
func on_enter():
	print("State: FALL")
	animatedSprite.play("fall")

func on_exit():
	pass


# state logic
func physics_process(delta):
	var player_velocity: Vector2 = player.velocity
	var player_gravity: int = player.gravity
	var player_speed: int = player.speed

	player_velocity.y += player_gravity
	player_velocity = player.move_and_slide(player_velocity, Vector2.UP)
