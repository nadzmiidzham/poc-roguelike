extends State

var animation
var movement_input

onready var is_wall_sliding := false
onready var is_wall_jumping := false

func on_enter():
	animation = owner.get_node("Animation")
	animation.play("idle")

func on_exit():
	is_wall_sliding = false
	is_wall_jumping = false

func process(_delta):
	movement_input = get_owner().get_movement_input()
	if abs(movement_input.x) <= 0:
		emit_signal("change_state", "idle")

	# reset state
	if !owner.is_touching_wall():
		is_wall_sliding = false
	if owner.is_grounded():
		is_wall_sliding = false
		is_wall_jumping = false

	# check flip
	if owner.is_facing_right && (movement_input.x < 0):
		owner.flip()
	elif !owner.is_facing_right && (movement_input.x > 0):
		owner.flip()

	# play animation
	if abs(movement_input.x) > 0:
		animation.play("move")
	if !owner.is_grounded() && is_wall_sliding:
		animation.play("wall_slide")
	if !owner.is_grounded() && (owner.velocity.y > 0) && !is_wall_sliding:
		animation.play("fall")
	elif !owner.is_grounded() && (owner.velocity.y < 0):
		animation.play("jump")

func physics_process(_delta):
	# movement
	if !is_wall_jumping:
		if Input.is_action_pressed("right"):
			owner.velocity.x = min(owner.velocity.x + owner.acceleration, owner.max_speed) # velocity cannot be more than max_speed
		elif Input.is_action_pressed("left"):
			owner.velocity.x = max(owner.velocity.x - owner.acceleration, -owner.max_speed) # velocity cannot be more than -max_speed
		else:
			owner.velocity.x = 0

	# jump
	if owner.is_grounded() && Input.is_action_just_pressed("jump"):
		owner.velocity.y = -owner.jump_force

	# wall slide
	if !owner.is_grounded() && owner.is_touching_wall() && owner.velocity.y > 0:
		var slide_speed = owner.gravity / 2
		owner.velocity.y = min(owner.velocity.y + slide_speed, owner.max_slide_speed)
		is_wall_sliding = true

	# wall jump
	if is_wall_sliding && Input.is_action_just_pressed("jump"):
		var direction = -1 if owner.is_facing_right else 1
		owner.velocity = Vector2(direction * owner.max_speed, -owner.jump_force)
		is_wall_sliding = false
		is_wall_jumping = true
