class_name StateIdle
extends Node

var state_machine: StateMachine

onready var player := get_node("../../")
onready var state_run := get_node("../Run")
onready var state_jump := get_node("../Jump")
onready var state_fall := get_node("../Fall")
onready var animated_sprite: AnimationPlayer = get_node("../../Animation")

# state machine functions
func on_enter() -> void:
	print("State: IDLE")
	animated_sprite.play("idle")

func on_exit() -> void:
	pass


# state logic
func process(_delta) -> void:
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		state_machine.change_state(state_run)
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(state_jump)
	if !player.is_on_floor():
		state_machine.change_state(state_fall)
