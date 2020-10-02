class_name Player
extends KinematicBody2D

export (int) var _gravity := 20 setget set_gravity, get_gravity
export (int) var _speed := 200 setget set_speed, get_speed
export (int) var _jump_force := 20 setget set_jump_force, get_jump_force

onready var is_facing_right := true
onready var _velocity := Vector2.ZERO setget set_velocity, get_velocity


# getter & setter
# velocity
func set_velocity(velocity: Vector2) -> void:
	_velocity = velocity
func get_velocity() -> Vector2:
	return _velocity

# gravity
func set_gravity(gravity: int) -> void:
	_gravity = gravity
func get_gravity() -> int:
	return _gravity

# speed
func set_speed(speed: int) -> void:
	_speed = speed
func get_speed() -> int:
	return _speed

# jump_force
func set_jump_force(jump_force: int) -> void:
	_jump_force = jump_force
func get_jump_force() -> int:
	return _jump_force


# other methods
func compute_gravity() -> void:
	_velocity.y += _gravity

func compute_velocity() -> void:
	_velocity = move_and_slide(_velocity, Vector2.UP)

func flip():
	is_facing_right = !is_facing_right
	self.scale.x *= -1
