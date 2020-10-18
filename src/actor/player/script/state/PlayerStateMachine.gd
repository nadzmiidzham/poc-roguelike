extends StateMachine

onready var idle := $Idle
onready var move := $Move

func _ready():
	state_map = {
		'idle': idle,
		'move': move
	}

func _unhandled_input(event): # handle input that can interrupt state
	pass
