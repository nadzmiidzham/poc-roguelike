extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var hurt := $Hurt
onready var die := $Die
onready var attack_basic := $AttackBasic
onready var attack_secondary := $AttackSecondary
onready var attack_special := $AttackSpecial


func _ready():
	state_map = {
		'idle': idle,
		'move': move,
		'hurt': hurt,
		'die': die,
		'attack_basic': attack_basic,
		'attack_secondary': attack_secondary,
		'attack_special': attack_special
	}
	interrupt_state = [
		'hurt',
		'die',
		'attack_basic',
		'attack_secondary',
		'attack_special'
	]

# interupt state
func _unhandled_input(event):
	if !no_interrupt && owner.is_grounded():
		if event.is_action_pressed("attack_special"):
			no_interrupt = true
			current_state.emit_signal("change_state", "attack_special")
		if event.is_action_pressed("attack_secondary"):
			no_interrupt = true
			current_state.emit_signal("change_state", "attack_secondary")
		if event.is_action_pressed("attack_basic"):
			no_interrupt = true
			current_state.emit_signal("change_state", "attack_basic")

func trigger_hurt():
	no_interrupt = true
	current_state.emit_signal("change_state", "hurt")

func trigger_die():
	no_interrupt = true
	current_state.emit_signal("change_state", "die")
