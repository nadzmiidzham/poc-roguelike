extends Node

var state_machine: StateMachine

onready var player := get_node("../../")
onready var state_run := get_node("../Run")
onready var state_fall := get_node("../Fall")
onready var animatedSprite: AnimationPlayer = get_node("../../Animation")

# state machine functions
func on_enter():
	print("State: IDLE")
	animatedSprite.play("idle")

func on_exit():
	pass


# state logic
func process(delta):
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		state_machine.change_state(state_run)
	if !player.is_on_floor():
		state_machine.change_state(state_fall)
