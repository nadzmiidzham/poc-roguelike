extends Node

var state_machine: StateMachine

onready var animatedSprite: AnimatedSprite = get_node("../../AnimatedSprite")

# state machine functions
func on_enter():
	print("State: IDLE")
	animatedSprite.play("idle")

func on_exit():
	pass
