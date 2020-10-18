class_name StateMachine
extends Node

export(NodePath) var initial_state

var state_map = {}
var state_stack = []
var current_state: Node = null

var _active = false setget set_active


# godot specific function
func _ready():
	if !initial_state:
		initial_state = get_child(0).get_path()
	for child in get_children():
		var err = child.connect("change_state", self, "_change_state") # create change_state signal to every child state
		if err:
			printerr(err)
	initialize(initial_state)

func _process(delta):
	current_state.process(delta)

func _physics_process(delta):
	current_state.physics_process(delta)

func _input(event):
	current_state.input(event)


# state machine function
func initialize(state):
	set_active(true)
	state_stack.push_front(get_node(state))
	current_state = state_stack[0]
	current_state.on_enter()

func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		state_stack = []
		current_state = null

func _change_state(state_name):
	if !_active:
		return

	current_state.on_exit()

	if state_name == 'previous':
		state_stack.pop_front()
	else:
		state_stack[0] = state_map[state_name]

	current_state = state_stack[0]

	if state_name != 'previous':
		current_state.on_enter()
