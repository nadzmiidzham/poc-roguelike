class_name PlayerBehaviour
extends KinematicBody2D

const GRAVITY := 20
const UP_DIRECTION := Vector2.UP

export(int) var spd := 200
export(int) var jump_force := 500

onready var velocity := Vector2.ZERO
onready var sprite: Sprite = get_node("Sprite")


func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = spd
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -spd
		sprite.flip_h = true
	else:
		velocity.x = 0

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_force

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, UP_DIRECTION)
