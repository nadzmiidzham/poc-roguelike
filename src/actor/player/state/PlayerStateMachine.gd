extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var attack_basic := $AttackBasic
onready var attack_secondary := $AttackSecondary
onready var attack_special := $AttackSpecial


func _ready():
	state_map = {
		'idle': idle,
		'move': move,
		'attack_basic': attack_basic,
		'attack_secondary': attack_secondary,
		'attack_special': attack_special
	}
	interrupt_state = [
		'attack_basic',
		'attack_secondary',
		'attack_special'
	]

# interupt state
func _unhandled_input(event):
	if !no_interrupt && event.is_action_pressed("attack_basic") && owner.is_grounded():
		no_interrupt = true
		current_state.emit_signal("change_state", "attack_basic")
	if !no_interrupt && event.is_action_pressed("attack_secondary") && owner.is_grounded():
		no_interrupt = true
		current_state.emit_signal("change_state", "attack_secondary")
	if !no_interrupt && event.is_action_pressed("attack_special") && owner.is_grounded():
		no_interrupt = true
		current_state.emit_signal("change_state", "attack_special")
