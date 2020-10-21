class_name BoxController
extends StaticBody2D


export(int) var max_hp := 3

onready var service := $Service
onready var animated_sprite := $AnimatedSprite


func _process(_delta):
	var model = service.get_model()
	
	if model.hp > 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("destroyed")


func damaged(value: int) -> void:
	print("box damaged for: " + str(value))
#	service.damage(value)
