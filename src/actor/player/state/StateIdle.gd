extends State

var animation


func on_enter():
	animation = owner.get_node("Animation")
	animation.play("idle")


func process(_delta):
	# get movement input
	var movement_input = owner.get_movement_input()
	if abs(movement_input.x) > 0:
		emit_signal("change_state", "move")

	# play animation
	if owner.is_grounded() && (owner.velocity == Vector2.ZERO):
		animation.play("idle")
	if !owner.is_grounded() && (owner.velocity.y > 0):
		animation.play("fall")
	elif !owner.is_grounded() && (owner.velocity.y < 0):
		animation.play("jump")

func physics_process(_delta):
	# jump
	if owner.is_grounded() && Input.is_action_just_pressed("jump"):
		owner.velocity.y = -owner.jump_force
