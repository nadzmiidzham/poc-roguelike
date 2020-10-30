class_name PlayerController
extends KinematicBody2D


export (int) var gravity := 20
export (float) var wall_slide_gravity_rate := 1.5
export (int) var acceleration := 20
export (int) var max_speed := 200
export (int) var max_slide_speed := 100
export (int) var jump_force := 550

onready var projectile = preload("res://prefab/actor/player/projectile.tscn")
onready var service := $Service as PlayerService
onready var ground_check := $GroundCheck
onready var front_check := $FrontCheck

onready var velocity := Vector2.ZERO
onready var is_facing_right := true


func _process(_delta):
	# print(str(service.get_hp()))
	pass

func _physics_process(_delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP) # compute velocity


func get_movement_input():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), velocity.y)

func flip():
	is_facing_right = !is_facing_right
	scale.x *= -1

func is_grounded():
	return ground_check.is_colliding()

func is_touching_wall():
	return front_check.is_colliding()

func on_damaged(value: float):
	print("Player Damaged: " + str(value))


func _on_AttackSecondary_spawn_projectile():
	var projectile_instance = projectile.instance()

	projectile_instance.damage = service.get_atk()
	projectile_instance.direction = Vector2.RIGHT if is_facing_right else Vector2.LEFT
	projectile_instance.position = get_global_position()
	get_parent().add_child(projectile_instance)

func _on_HitBox_area_entered(area):
	if area.has_method("on_damaged"):
		area.on_damaged(service.get_atk())

func _on_HurtBox_on_damaged(value):
	service.damaged(value)
