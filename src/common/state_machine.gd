class_name StateMachine
extends Node


var _state: Object # state node

# init state machine
# Set the initial state to the first child node
func _ready():
	change_state(get_child(0))


# Route Game Loop function calls to current state handler method if it exists
func _process(delta):
	if _state.has_method("process"):
		_state.process(delta)

func _physics_process(delta):
	if _state.has_method("physics_process"):
		_state.physics_process(delta)

func _input(event):
	if _state.has_method("input"):
		_state.input(event)


# state machine specific function
func change_state(new_state):
	if (_state == null) || (_state.get_name() != new_state.get_name()):
		if _state != null:
			_state.on_exit()
		_state = new_state
		_state.state_machine = self # Give the new state a reference to this state machine script
		_state.on_enter()
