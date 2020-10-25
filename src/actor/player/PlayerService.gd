class_name PlayerService
extends Node


onready var model := $Model


func get_atk() -> int:
	return model.atk

func get_max_hp() -> int:
	return model.max_hp

func get_hp() -> int:
	return model.hp


func update_max_hp(value: int) -> void:
	model.max_hp = value

func update_hp(value: int) -> void:
	model.hp = clamp(value, 0, model.max_hp)

func update_atk(value: int) -> void:
	model.atk = value
