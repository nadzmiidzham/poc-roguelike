extends StaticBody2D


signal update_hp(hp)

export(int) var max_hp := 3

onready var animated_sprite := $AnimatedSprite
onready var hp = max_hp setget _set_hp


func _process(_delta):
	if hp > 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("destroyed")


func damage(value):
	_set_hp(hp - value)

func _set_hp(value):
	if value != hp:
		emit_signal("update_hp", value)
	hp = clamp(value, 0, max_hp)
