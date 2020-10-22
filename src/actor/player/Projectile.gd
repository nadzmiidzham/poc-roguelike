class_name Projectile
extends KinematicBody2D


export (Vector2) var direction := Vector2.RIGHT

onready var animated_sprite := $AnimatedSprite
onready var delete_timer := $DeleteTimer

onready var projection_speed := 400
onready var velocity := Vector2.ZERO

func _ready():
	scale.x *= direction.x
	delete_timer.start()
	animated_sprite.play("default")

func _physics_process(_delta):
	velocity.x = direction.x * projection_speed
	velocity = move_and_slide(velocity)


func _on_DeleteTimer_timeout():
	self.queue_free()
