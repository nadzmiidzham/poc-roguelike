class_name StateFall
extends Node


onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

var state_machine: StateMachine
var is_wall_sliding := false

# state machine functions
func on_enter() -> void:
	print("State: FALL")
	animatedSprite.play("fall")

func on_exit() -> void:
	is_wall_sliding = false


# state logic
func process(_delta) -> void:
	player.check_flip()
	if player.is_on_floor():
		state_machine.change_state(state_idle)

func physics_process(_delta) -> void:
	if player.is_on_wall():
		is_wall_sliding = true
		player.velocity.y = min(player.velocity.y + player.wall_slide_speed, player.wall_slide_speed)

	player.move()
	player.compute_gravity()
	player.compute_velocity()
