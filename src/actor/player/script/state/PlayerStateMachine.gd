extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var attack_basic := $AttackBasic
onready var attack_secondary := $AttackSecondary


func _ready():
	state_map = {
		'idle': idle,
		'move': move,
		'attack_basic': attack_basic,
		'attack_secondary': attack_secondary
	}
	interrupt_state = [
		'attack_basic',
		'attack_secondary'
	]

func _unhandled_input(event):
	if !no_interrupt && event.is_action_pressed("attack_basic"):
		no_interrupt = true
		current_state.emit_signal("change_state", "attack_basic")
	if !no_interrupt && event.is_action_pressed("attack_secondary"):
		no_interrupt = true
		current_state.emit_signal("change_state", "attack_secondary")
