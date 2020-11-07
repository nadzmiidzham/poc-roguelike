class_name HurtBox
extends Area2D

signal on_damaged(value)
signal on_hurtbox_active()

onready var active := true

onready var timer := $Timer


func on_damaged(value):
	if active:
		emit_signal("on_damaged", value)
		self.active = false
		timer.start()


func _on_Timer_timeout():
	emit_signal("on_hurtbox_active")
	self.active = true
