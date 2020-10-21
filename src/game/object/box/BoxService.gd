class_name BoxService
extends Node


onready var model := $Model

func get_model() -> BoxModel:
	return model as BoxModel


func damage(value: int) -> void:
	model.hp = clamp(model.hp - value, 0, model.max_hp)
