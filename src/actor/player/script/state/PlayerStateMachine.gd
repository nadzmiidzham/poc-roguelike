extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var attack := $Attack

func _ready():
	state_map = {
		'idle': idle,
		'move': move,
		'attack': attack
	}

func _unhandled_input(event):
	if event.is_action_pressed("attack_basic"):
		current_state.emit_signal("change_state", "attack")
