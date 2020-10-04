class_name Player
extends KinematicBody2D

export (int) var gravity := 20
export (int) var speed := 200
export (int) var jump_force := 20
export (float) var wall_slide_gravity_rate := 1.5

onready var is_facing_right := true
onready var velocity := Vector2.ZERO


# other methods
func compute_gravity() -> void:
	velocity.y += gravity

func compute_velocity() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

func move() -> void:
	var right_input = Input.is_action_pressed("move_right")
	var left_input = Input.is_action_pressed("move_left")

	velocity.x = (int(right_input) - int(left_input)) * speed

func check_flip() -> void:
	if !is_facing_right && (velocity.x > 0):
		is_facing_right = !is_facing_right
		self.scale.x *= -1
	if is_facing_right && (velocity.x < 0):
		is_facing_right = !is_facing_right
		self.scale.x *= -1
