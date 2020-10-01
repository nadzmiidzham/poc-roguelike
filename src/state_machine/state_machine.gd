class_name StateMachine
extends Node


var state: Object # state node

# init state machine
# Set the initial state to the first child node
func _ready():
	change_state(get_child(0))


# Route Game Loop function calls to current state handler method if it exists
func _process(delta):
	if state.has_method("process"):
		state.process(delta)

func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)

func _input(event):
	if state.has_method("input"):
		state.input(event)


# state machine specific function
func change_state(new_state):
	if self.state != new_state:
		if self.state != null:
			state.on_exit()
		state = new_state

		# Give the new state a reference to this state machine script
		state.state_machine = self
		state.on_enter()
