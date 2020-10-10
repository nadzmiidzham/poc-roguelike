class_name Player
extends KinematicBody2D

export (int) var gravity := 20
export (int) var max_speed := 200
export (int) var max_slide_speed := 100
export (int) var acceleration := 20
export (int) var jump_force := 550
export (float) var wall_slide_gravity_rate := 1.5

onready var animation := $Animation
onready var ground_check := $GroundCheck
onready var front_check := $FrontCheck

onready var velocity := Vector2.ZERO
onready var linear_drag := 0.2
onready var cur_attack_time := 1
onready var max_attack_time := 3
onready var is_facing_right := true
onready var is_wall_sliding := false
onready var is_wall_jumping := false


func _physics_process(delta):
	velocity.y += gravity # compute gravity

	# movement
	if !is_wall_jumping:
		if Input.is_action_pressed("right"):
			velocity.x = min(velocity.x + acceleration, max_speed) # velocity cannot be more than max_speed
			if is_grounded():
				animation.play("run")
		elif Input.is_action_pressed("left"):
			velocity.x = max(velocity.x - acceleration, -max_speed) # velocity cannot be more than -max_speed
			if is_grounded():
				animation.play("run")
		else:
			velocity.x = lerp(velocity.x, 0, 0.2)
			if is_grounded():
				animation.play("idle")

	# fall & jump
	if !is_wall_sliding && is_grounded() && Input.is_action_just_pressed("jump"):
			velocity.y = -jump_force

	if !is_grounded() && velocity.y > 0:
		animation.play("fall")
	elif (is_grounded() || is_wall_jumping) && velocity.y < 0:
		animation.play("jump")

	# wall slide & wall jump
	if !is_grounded() && is_touching_wall() && velocity.y > 0:
		var slide_speed = gravity / 2
		velocity.y = min(velocity.y + slide_speed, max_slide_speed)
		is_wall_sliding = true
		animation.play("wall_slide")

	if is_wall_sliding && Input.is_action_just_pressed("jump"):
		var direction = -1 if is_facing_right else 1
		velocity = Vector2(direction * max_speed, -jump_force)
		is_wall_sliding = false
		is_wall_jumping = true

	if !is_touching_wall():
		is_wall_sliding = false
	if is_grounded():
		is_wall_jumping = false

	velocity = move_and_slide(velocity, Vector2.UP) # compute velocity

func _input(event):
	if (!is_facing_right && event.is_action_pressed("right")) || (is_facing_right && event.is_action_pressed("left")):
		flip()

func flip():
	is_facing_right = !is_facing_right
	scale.x *= -1

func is_grounded():
	return ground_check.is_colliding()

func is_touching_wall():
	return front_check.is_colliding()
