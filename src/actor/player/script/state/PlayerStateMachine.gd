extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var attack_basic := $AttackBasic


func _ready():
	state_map = {
		'idle': idle,
		'move': move,
		'attack_basic': attack_basic
	}
	interrupt_state = [
		'attack_basic'
	]

func _unhandled_input(event):
	if event.is_action_pressed("attack_basic"):
		current_state.emit_signal("change_state", "attack_basic")
