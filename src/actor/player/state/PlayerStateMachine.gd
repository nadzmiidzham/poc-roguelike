extends StateMachine


export(NodePath) var service_path

onready var idle := $Idle
onready var move := $Move
onready var hurt := $Hurt
onready var die := $Die
onready var attack_basic := $AttackBasic
onready var attack_secondary := $AttackSecondary
onready var attack_special := $AttackSpecial
onready var service := get_node(service_path)
onready var secondary_active := true
onready var special_active := true


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
	var player_ep = service.get_stat().ep

	if !no_interrupt && owner.is_grounded():
		if (player_ep > 0) && special_active && event.is_action_pressed("attack_special"):
			no_interrupt = true
			special_active = false
			current_state.emit_signal("change_state", "attack_special")
		if (player_ep > 0) && secondary_active && event.is_action_pressed("attack_secondary"):
			no_interrupt = true
			secondary_active = false
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


func _on_SecondaryCooldown_timeout():
	secondary_active = true

func _on_SpecialCooldown_timeout():
	special_active = true
