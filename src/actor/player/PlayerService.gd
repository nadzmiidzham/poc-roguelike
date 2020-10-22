class_name PlayerService
extends Node


onready var model := $Model

func get_model() -> PlayerModel:
	return model as PlayerModel


func on_attack() -> int:
	return model.atk

func on_damage(value: int) -> void:
	model.hp = clamp(model.hp - value, 0, model.max_hp)
