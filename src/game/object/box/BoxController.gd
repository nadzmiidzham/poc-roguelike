class_name BoxController
extends StaticBody2D


export(int) var max_hp := 3

onready var service := $Service
onready var animated_sprite := $AnimatedSprite
onready var collision := $CollisionShape2D
onready var hurt_box := $HurtBox


func _process(_delta):
	if service.get_hp() > 0:
		animated_sprite.play("idle")
	else:
		on_destroyed()

func on_destroyed():
		animated_sprite.play("destroyed")
		collision.disabled = true
		collision.visible = false
		hurt_box.visible = false

func on_damaged(value: int) -> void:
	service.update_hp(service.get_hp() - value)
