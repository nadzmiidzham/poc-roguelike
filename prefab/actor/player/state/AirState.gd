extends State


export (NodePath) var animation_player_path
export (NodePath) var idle_state_path
export (Dictionary) var jump_animation # { 'name': 'idle', 'animation': <<resource>> }
export (Dictionary) var fall_animation # { 'name': 'idle', 'animation': <<resource>> }

onready var animation_player := get_node(animation_player_path)
onready var idle_state := get_node(idle_state_path)

var jump_force: float
var velocity: Vector2


func _ready() -> void:
	animation_player.connect("animation_finished", self, '_on_animation_finished')
	animation_player.add_animation(jump_animation['name'], jump_animation['animation'])
	animation_player.add_animation(fall_animation['name'], fall_animation['animation'])


func on_enter(data: Dictionary = {}) -> void:
	velocity = owner.get_velocity()
	jump_force = owner.get_jump_force()

	if data && data.jumping:
		animation_player.play(jump_animation['name'])
	else:
		animation_player.play(fall_animation['name'])

func on_exit() -> void:
	animation_player.stop(true)


func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	var current_velocity = owner.get_velocity()

	owner.move()

	if (current_velocity.y > velocity.y) && owner.is_grounded():
		state_machine.change_state(idle_state, { "landing": true })



func _on_animation_finished(name: String) -> void:
	if name == jump_animation['name']:
		velocity.y = -jump_force
		owner.set_velocity(velocity)
		animation_player.play(fall_animation['name'])
