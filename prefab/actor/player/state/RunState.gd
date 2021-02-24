extends State


export (NodePath) var animation_player_path
export (NodePath) var idle_state_path
export (NodePath) var air_state_path
export (Dictionary) var run_animation # { 'name': 'idle', 'animation': <<resource>> }

onready var animation_player := get_node(animation_player_path)
onready var idle_state := get_node(idle_state_path)
onready var air_state := get_node(air_state_path)

var movement: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var acceleration: float = 0.0
var max_speed: float = 0.0


func _ready() -> void:
	animation_player.add_animation(run_animation['name'], run_animation['animation'])


func on_enter(_data: Dictionary = {}) -> void:
	animation_player.play(run_animation['name'])

func on_exit() -> void:
	animation_player.stop(true)


func process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(air_state, { "jumping": true })

func physics_process(_delta: float) -> void:
	movement = owner.get_movement_input()
	velocity = owner.get_velocity()
	acceleration = owner.get_acceleration()
	max_speed = owner.get_max_speed()

	if abs(movement.x) == 0.0:
		state_machine.change_state(idle_state)

	owner.move()
