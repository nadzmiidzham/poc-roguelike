class_name Player
extends KinematicBody2D

export (int) var gravity := 20
export (int) var speed := 200
export (Vector2) var velocity := Vector2.ZERO

onready var state_machine := $State

var is_facing_right := true

func _process(_delta):
	if (velocity == Vector2.ZERO) && is_on_floor():
		state_machine.change_state($State/Idle)
	if (abs(velocity.x) > 0) && is_on_floor():
		state_machine.change_state($State/Run)
	if !is_on_floor():
		state_machine.change_state($State/Fall)


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0

	# flip
	if velocity.x != 0:
		if (is_facing_right && (velocity.x < 0)) || (!is_facing_right && (velocity.x > 0)):
			scale.x *= -1
