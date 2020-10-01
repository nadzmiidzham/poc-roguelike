extends Node

var state_machine: StateMachine

onready var player := get_node("../../")
onready var animatedSprite: AnimatedSprite = get_node("../../AnimatedSprite")

# state machine functions
func on_enter():
	print("State: RUN")
	animatedSprite.play("run")

func on_exit():
	pass


# state logic
func physics_process(delta):
	var player_velocity: Vector2 = player.velocity
	var player_speed: int = player.speed

	player_velocity = player.move_and_slide(player_velocity, Vector2.UP)
