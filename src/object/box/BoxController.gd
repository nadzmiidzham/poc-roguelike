class_name BoxController
extends StaticBody2D


export(int) var max_hp := 3

onready var service := $Service
onready var animated_sprite := $AnimatedSprite
onready var collision := $CollisionShape2D
onready var hit_timer := $HitTimer

onready var damageable := true
onready var color_damaged := Color(1, 0, 0, 0.8)


func _process(_delta):
	if service.get_hp() > 0:
		animated_sprite.play("idle")
	else:
		on_destroyed()


func on_destroyed():
		animated_sprite.play("destroyed")
		collision.disabled = true
		collision.visible = false


func _on_HitTimer_timeout():
	damageable = true
	animated_sprite.self_modulate = Color(1, 1, 1, 1)

func _on_HurtBox_on_damaged(value):
	if damageable:
		damageable = false
		hit_timer.start()
		animated_sprite.self_modulate = color_damaged
		service.update_hp(service.get_hp() - value)
