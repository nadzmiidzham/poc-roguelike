class_name StateFall
extends Node


onready var player := get_node("../../")
onready var state_idle := get_node("../Idle")
onready var animated_sprite: AnimationPlayer = get_node("../../Animation")

var state_machine: StateMachine
var is_wall_sliding := false
var is_wall_jumping := false

# state machine functions
func on_enter() -> void:
	print("State: FALL")
	animated_sprite.play("fall")

func on_exit() -> void:
	is_wall_sliding = false
	is_wall_jumping = false


# state logic
func process(_delta) -> void:
	if is_wall_sliding:
		animated_sprite.play("wall_slide")
	else:
		animated_sprite.play("fall")
	if player.is_on_floor():
		state_machine.change_state(state_idle)

	player.check_flip()

func physics_process(_delta) -> void:
	if player.is_on_wall():
		var wall_slide_speed = player.gravity / player.wall_slide_gravity_rate;
		is_wall_sliding = true
		player.velocity.y = min(player.velocity.y + wall_slide_speed, wall_slide_speed)
	if is_wall_sliding && Input.is_action_just_pressed("jump"):
		is_wall_sliding = false
		is_wall_jumping = true

		var direction = -1 if player.is_facing_right else 1
		player.velocity = Vector2(direction * player.speed, -player.jump_force)

	if !is_wall_jumping:
		player.move()
	player.compute_gravity()
	player.compute_velocity()
