class_name HurtBox
extends Area2D

signal on_damaged(value)

onready var active := true

onready var timer := $Timer


func on_damaged(value):
	if active:
		emit_signal("on_damaged", value)
		active = false
		timer.start()


func _on_Timer_timeout():
	active = true
