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
onready var cur_basic_attack_time := 1
onready var max_basic_attack_time := 3
onready var is_facing_right := true
onready var is_wall_sliding := false
onready var is_wall_jumping := false
onready var is_attacking := false


func _process(delta):
	# run animation
	if is_attacking:
		animation.play("attack_basic_1")
		return

	if is_grounded():
		if abs(velocity.x) > 0:
			animation.play("run")
		else:
			animation.play("idle")

	if !is_grounded() && (velocity.y > 0):
		animation.play("fall")
	elif (is_grounded() || is_wall_jumping) && (velocity.y < 0):
		animation.play("jump")

	if is_wall_sliding:
		animation.play("wall_slide")

func _physics_process(delta):
	velocity.y += gravity # compute gravity

	# movement
	if !is_wall_jumping:
		if Input.is_action_pressed("right"):
			velocity.x = min(velocity.x + acceleration, max_speed) # velocity cannot be more than max_speed
		elif Input.is_action_pressed("left"):
			velocity.x = max(velocity.x - acceleration, -max_speed) # velocity cannot be more than -max_speed
		else:
			velocity.x = 0 # lerp(velocity.x, 0, 0.5)

	# fall & jump
	if !is_attacking && !is_wall_sliding && is_grounded() && Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force

	# wall slide & wall jump
	if !is_grounded() && is_touching_wall() && velocity.y > 0:
		var slide_speed = gravity / 2
		velocity.y = min(velocity.y + slide_speed, max_slide_speed)
		is_wall_sliding = true

	if is_wall_sliding && Input.is_action_just_pressed("jump"):
		var direction = -1 if is_facing_right else 1
		velocity = Vector2(direction * max_speed, -jump_force)
		is_wall_sliding = false
		is_wall_jumping = true

	if !is_touching_wall():
		is_wall_sliding = false
	if is_grounded():
		is_wall_jumping = false

	# attack
	if !is_touching_wall() && Input.is_action_just_pressed("attack_1"):
		is_attacking = true

	# prevent ground movement while attacking
	if is_attacking && is_grounded():
		velocity.x = 0

	velocity = move_and_slide(velocity, Vector2.UP) # compute velocity

func _input(event):
	if (!is_facing_right && event.is_action_pressed("right")) || (is_facing_right && event.is_action_pressed("left")):
		if is_attacking:
			return
		flip()


func flip():
	is_facing_right = !is_facing_right
	scale.x *= -1

func is_grounded():
	return ground_check.is_colliding()

func is_touching_wall():
	return front_check.is_colliding()

func animation_finished():
	if (!is_facing_right && Input.is_action_pressed("right")) || (is_facing_right && Input.is_action_pressed("left")):
		flip()
	is_attacking = false
