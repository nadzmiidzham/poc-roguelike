class_name Player
extends KinematicBody2D


export (float) var wall_slide_gravity_rate := 1.5
export (int) var max_slide_speed := 100

onready var wall_check := $WallCheck

var _is_facing_right: bool = true
var _acceleration: float = 20.0 setget set_acceleration, get_acceleration
var _max_speed: float = 200.0 setget set_max_speed, get_max_speed
var _velocity: Vector2 = Vector2.ZERO setget set_velocity, get_velocity
var _gravity: float = 20.0 setget set_gravity, get_gravity
var _jump_force: float = 550.0 setget set_jump_force, get_jump_force


func _physics_process(_delta) -> void:
	var movement_input: Vector2 = get_movement_input()

	if _is_facing_right && (movement_input.x < 0.0):
		flip()
	elif !_is_facing_right && (movement_input.x > 0.0):
		flip()

	_velocity.y += _gravity
	_velocity = move_and_slide(_velocity, Vector2.UP) # compute velocity


# setter
func set_velocity(value: Vector2) -> void:
	_velocity = value

func set_acceleration(value: float) -> void:
	_acceleration = value

func set_max_speed(value: float) -> void:
	_max_speed = value

func set_gravity(value: float) -> void:
	_gravity = value

func set_jump_force(value: float) -> void:
	_jump_force = value


# getter
func get_velocity() -> Vector2:
	return _velocity

func get_acceleration() -> float:
	return _acceleration

func get_max_speed() -> float:
	return _max_speed

func get_gravity() -> float:
	return _gravity

func get_jump_force() -> float:
	return _jump_force

func get_movement_input() -> Vector2:
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), _velocity.y)

func is_grounded() -> bool:
	return is_on_floor()

func is_touching_wall() -> bool:
	return wall_check.is_colliding()


# other methods
func move() -> void:
	var movement = get_movement_input()

	if movement.x > 0:
		_velocity.x = min(_velocity.x + _acceleration, _max_speed) # velocity cannot be more than max_speed
	elif movement.x < 0:
		_velocity.x = max(_velocity.x - _acceleration, -_max_speed) # velocity cannot be less than -max_speed
	elif movement.x == 0:
		_velocity.x = 0

func flip() -> void:
	_is_facing_right = !_is_facing_right
	scale.x *= -1
