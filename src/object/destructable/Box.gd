extends Area2D

export(int) var hp := 2

onready var animated_sprite := $DestructibleSprite
onready var collision := $DestructibleCollision

func _process(_delta):
	if hp <= 0:
		animated_sprite.play("destroyed")
		collision.set_disabled(false)


func _on_Destructable_area_entered(area):
	if hp > 0:
		hp -= 1
