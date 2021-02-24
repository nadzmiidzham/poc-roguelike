class_name StateMachine
extends Node


export (NodePath) var initial_state_path

onready var active_state := get_node(initial_state_path)


func _ready() -> void:
	active_state.on_enter()

func _process(delta) -> void:
	active_state.process(delta)

func _physics_process(delta) -> void:
	active_state.physics_process(delta)


func change_state(state: Node, data: Dictionary = {}) -> void:
	if active_state != state:
		active_state.on_exit()
		active_state = state
		active_state.on_enter(data)
