class_name Player
extends KinematicBody2D

export (int) var gravity := 20
export (int) var speed := 200
export (int) var jump_force := 20

onready var is_facing_right := true
onready var velocity := Vector2.ZERO


# other methods
func compute_gravity() -> void:
	velocity.y += gravity

func compute_velocity() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

func move() -> void:
	if Input.is_action_pressed("move_right"):
		velocity = Vector2(speed, velocity.y)
	elif Input.is_action_pressed("move_left"):
		velocity = Vector2(-speed, velocity.y)
	else:
		velocity = Vector2(0, velocity.y)

func flip() -> void:
	is_facing_right = !is_facing_right
	self.scale.x *= -1
