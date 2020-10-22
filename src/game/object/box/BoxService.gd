class_name BoxService
extends Node


onready var model := $Model


func get_hp() -> int:
	return model.hp

func update_hp(value: int) -> void:
	model.hp = clamp(value, 0, model.max_hp)
