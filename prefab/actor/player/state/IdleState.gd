extends State


export (NodePath) var animation_player_path
export (NodePath) var run_state_path
export (NodePath) var air_state_path
export (Dictionary) var idle_animation # { 'name': 'idle', 'animation': <<resource>> }
export (Dictionary) var land_animation # { 'name': 'idle', 'animation': <<resource>> }

onready var animation_player := get_node(animation_player_path)
onready var run_state := get_node(run_state_path)
onready var air_state := get_node(air_state_path)

var has_landed: bool


func _ready() -> void:
	animation_player.connect("animation_finished", self, '_on_animation_finished')
	animation_player.add_animation(idle_animation['name'], idle_animation['animation'])
	animation_player.add_animation(land_animation['name'], land_animation['animation'])


func on_enter(data: Dictionary = {}) -> void:
	owner.set_velocity(Vector2.ZERO)

	if data && data.landing:
		has_landed = false
		animation_player.play(land_animation['name'])
	else:
		has_landed = true
		animation_player.play(idle_animation['name'])

func on_exit() -> void:
	animation_player.stop(true)


func process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(air_state, { "jumping": true })

func physics_process(_delta: float) -> void:
	var movement: Vector2 = owner.get_movement_input()

	if has_landed && abs(movement.x) > 0.01:
		state_machine.change_state(run_state)


func _on_animation_finished(name: String) -> void:
	if name == land_animation['name']:
		has_landed = true
